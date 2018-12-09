extends "res://actors/Health.gd"

#Signals are great for calling methods in
#physics objects. Godot does not crash if it
#attempts to emit a signal inside a body
#that does not exist.

#These are the constants that will always be
#affecting us.
const DOUBLE_JUMP = -1000
const FLOOR = Vector2( 0,-1 )
const GRAVITY_ADD = 70
const GRAVITY_MAX = 600
const JUMP_STRENGTH = -300
const JUMP_STAGE_1 = 0.011167 * 5
const JUMP_STAGE_2 = 0.011167 * 8
const JUMP_STAGE_3 = 0.011167 * 10
const JUMP_STAGE_MAX = 3

#State Machine
var FSM = {
	"Default" : "default",
	"Dash" : "dash"
	}
var fsm_state = "Default" 


#Determines the velocity
var velocity : Vector2 = Vector2( 0,0 )

#Use this to determine jump height.
var jump_held : float = 0
var jump_stage : int = 1
var jump_mod : Array = [ 0, -140, -200, -300 ]
var allow_slope = false #Fixes slopes messing with jumps.

#This allows us to double jump.
var has_double_jump = true

#Dash variables
const DASH_COOLDOWN_LENGTH = 0.011167 * 20
const DASH_DURATION = 0.011167 * 40
const DASH_SPEED = 500
const DASH_PUSHBACK = 30
var dash_cooldown = 0
var dash_lasted = 0
var dash_direction = 1

#Determines how large the snowman is.
var size = 1
onready var original_col_extents = $Col.shape.extents
onready var original_sprite_scale = $Sprite.scale

var JUMP = 1
var RUNNING = 2
var IDLE = 3
var state = JUMP


func _process(delta):
	#Quick left right handling.
	#I will eventually replace this with
	#a controller input handling class.
	velocity.x = (int( Input.is_action_pressed("ui_right") ) - 
	int( Input.is_action_pressed( "ui_left" ) ) ) * 200
	
	call( "process_" + FSM[fsm_state], delta )


func change_scale( new_scale : float ):
	#Change the size of the snowman
	#Eventually we will better handle scaling.
	$Col.shape.extents = original_col_extents * new_scale
	$Sprite.scale = original_sprite_scale * new_scale


func health_gone():
	#My health has been depleted.
	#Play the death animation and die.
	pass


func jump_held( delta ):
	#Determines how strong the jump should be.
	if Input.is_action_pressed( "jump" ) :
		jump_held += delta
		
		velocity.y = JUMP_STRENGTH + jump_mod[ jump_stage ]
		if jump_stage == 2 :
			pass  
		
		if jump_held >= get( "JUMP_STAGE_" + str( jump_stage ) ) :
			jump_stage += 1
			
			if jump_stage > JUMP_STAGE_MAX :
				jump_held = 0
				jump_stage = 1
	
	else:
		jump_held = 0
		jump_stage = 1


func on_floor():
	var on_floor = false
	$Floor1.update()
	$Floor2.update()
	if state == JUMP:
		$AnimatedSprite.animation = "Idle"
		state = IDLE
	if state == RUNNING:
		$AnimatedSprite.animation = "Running"
	
	if $Floor1.is_colliding() || $Floor2.is_colliding():
		on_floor = true
	
	return on_floor


func process_dash( delta ):
	#Start a dash.
	dash_lasted += delta
	
	move_and_slide( Vector2( dash_direction * DASH_SPEED, 0 ) )
	
	if is_on_wall():
		self.position.x += DASH_PUSHBACK * sign(-dash_direction)
		fsm_state = "Default"
		dash_lasted = 0
		dash_cooldown = DASH_COOLDOWN_LENGTH
		$DashHitbox.is_activated( false )
		$Hurtbox.is_activated( true )
		return
	
	if dash_lasted >= DASH_DURATION :
		fsm_state = "Default"
		dash_lasted = 0
		dash_cooldown = DASH_COOLDOWN_LENGTH
		$DashHitbox.is_activated( false )
		$Hurtbox.is_activated( true )


func process_default( delta ):
	#Start a dash if player inputs it.
	if( Input.is_action_just_pressed("dash") &&
	dash_cooldown <= 0 ):
		fsm_state = "Dash"
		velocity.y = 0
		$DashHitbox.is_activated( true )
		$Hurtbox.is_activated( false )
		dash_direction = sign(velocity.x)
		if dash_direction == 0 :
			dash_direction = 1
		return
	
	dash_cooldown = max( dash_cooldown - delta, 0 )
	
	#Calculate velocity's y value.
	velocity.y = min( velocity.y + GRAVITY_ADD, GRAVITY_MAX )
				
	$AnimatedSprite.play()
	if velocity.x > 0 and state != JUMP:
		state = RUNNING
		
	if jump_held > 0 :
		jump_held( delta )

	allow_slope = false
	if on_floor() && velocity.y >= 0:
		has_double_jump = true
		allow_slope = true
		jump_held = 0
		velocity.y = 0
		if Input.is_action_just_pressed( "jump" ) :
			velocity.y = JUMP_STRENGTH
			jump_held += delta
	
	elif has_double_jump :
			if Input.is_action_just_pressed( "jump" ) :
				has_double_jump = false
				velocity.y = DOUBLE_JUMP
				$AnimatedSprite.animation = "Jumping"
				state = JUMP
	
	$Ceiling.update()
	if $Ceiling.is_colliding() && velocity.y <= 0:
		jump_held = 0
		velocity.y = 0
	
	#Code for Animations states		
	if state == JUMP and velocity.y > 0:
		$AnimatedSprite.animation = "Falling"
	#if state == JUMP and is_on_floor():
		#$AnimatedSprite.animation = "idle"
	if  velocity.x < 0 :
		$AnimatedSprite.flip_h = true
	if  velocity.x > 0 :
		$AnimatedSprite.flip_h = false	
	
	move_and_slide_with_snap( velocity.rotated( slope() ) , Vector2( 0, -1 ), FLOOR )


func slope():
	#Returns the slope's angle.
	var slope = Vector2( 0,0 )
	if $Floor1.is_colliding() :
		slope = $Floor1.get_collision_normal()
	
	elif $Floor2.is_colliding() :
		slope = $Floor2.get_collision_normal()
	

	return slope.rotated( 1.570796 ).angle() * int( allow_slope )
