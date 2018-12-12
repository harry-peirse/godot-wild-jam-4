extends "res://actors/physics/Physics.gd"

#Signals are great for calling methods in
#physics objects. Godot does not crash if it
#attempts to emit a signal inside a body
#that does not exist.

#These are the constants that will always be
#affecting us.
const DOUBLE_JUMP = -1000
const JUMP_STRENGTH = -300
const JUMP_STAGE_1 = 0.011167 * 5
const JUMP_STAGE_2 = 0.011167 * 8
const JUMP_STAGE_3 = 0.011167 * 10
const JUMP_STAGE_MAX = 3

#This prevents the Snowman from walking or
#dashing.
export var can_navigate = true


#State Machine
var FSM = {
	"Default" : "default",
	"Dash" : "dash",
	"Hitstun" : "hitstun"
	}
var fsm_state = "Default" 

#enum state {IDLE,RUN,JUMP,HURT,DEAD,DASH}
#var current_state = state.IDLE

#Determines the velocity
#var was_in_air = true

#Hitstun
const HITSTUN_WAIT = 0.011167 * 15
var hitstun_left = HITSTUN_WAIT

#Use this to determine jump height.
var jump_held : float = 0
var jump_stage : int = 1
var jump_mod : Array = [ 0, -140, -200, -300 ]

#This allows us to double jump.
signal double_jump
var has_double_jump = true

#Dash variables
signal dash
const DASH_COOLDOWN_LENGTH = 0.051167 * 20
const DASH_DURATION = 0.011167 * 40
const DASH_SPEED = 500
const DASH_PUSHBACK = 30
var dash_cooldown = 0
var dash_lasted = 0
var dash_direction = 1

onready var original_scale = Vector2(scale.x, scale.y)
var size = 1;


func _process(delta):
	if can_navigate :
		handle_input( delta )
	call( "process_" + FSM[fsm_state], delta )



func _physics_process(delta):
	scale = original_scale * size


func _ready():
	self.connect( "pushback", self, "pushback" )
	self.connect( "foot_stomped", self, "foot_stomped" )
	$AnimatedSprite.play()
	$DashFX.emitting = false
	$DoubleJumpFX.emitting = false


func been_hit( push : Vector2, damaged = false ):
	#Start hitstun state.
	fsm_state = "Hitstun"


func foot_stomped( push : Vector2 ):
	self.velocity.y = 0
	velocity += push

	
func handle_input( delta ):
	#Quick left right handling.
	#I will eventually replace this with
	#a controller input handling class.
	velocity.x = (int( Input.is_action_pressed("ui_right") ) - 
	int( Input.is_action_pressed( "ui_left" ) ) ) * 200
	
	# Controlling the direction that the dash will be performed based on the direction of the snowman
	# It's no longer necessary to hold down the direction button whilst dashing to prevent the snowman dashing right when facing left.
	if Input.is_action_pressed("ui_left"):
		dash_direction = -1
		
	elif Input.is_action_pressed("ui_right"):
		dash_direction = 1
	
	#Start a dash if player inputs it.
	if( Input.is_action_just_pressed("dash") &&
	dash_cooldown <= 0 ):
		emit_signal( "dash", true )
		fsm_state = "Dash"
		velocity.y = 0
		$DashHitbox.is_activated( true )
		$Hurtbox.is_activated( false )
		$SFXLibrary/DashSFX.play()
	
	dash_cooldown = max( dash_cooldown - delta, 0 )


func health_gone():
	#My health has been depleted.
	#Play the death animation and die.
	pass


func jump_held( delta ):
	#Determines how strong the jump should be.
	if Input.is_action_pressed( "jump" ) :
		jump_held += delta
		$SFXLibrary/JumpSFX.play()
		$AnimatedSprite.animation = "Jumping"
		
		velocity.y = JUMP_STRENGTH + jump_mod[ jump_stage ] * size
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
		emit_signal( "dash", false )
		return
	
	if dash_lasted >= DASH_DURATION :
		fsm_state = "Default"
		dash_lasted = 0
		dash_cooldown = DASH_COOLDOWN_LENGTH
		$DashHitbox.is_activated( false )
		$Hurtbox.is_activated( true )
		emit_signal( "dash", false )


func process_default( delta ):
	if jump_held > 0 :
		jump_held( delta )
	
	handle_physics( delta )

	#Compute floor logic.
	if on_floor :
		has_double_jump = true
		jump_held = 0
		if Input.is_action_just_pressed( "jump" ) :
			velocity.y = JUMP_STRENGTH
			jump_held += delta
	
	elif has_double_jump :
			if Input.is_action_just_pressed( "jump" ) :
				emit_signal( "double_jump" )
				has_double_jump = false
				velocity.y = DOUBLE_JUMP
				$DoubleJumpFX.emitting = true
				$SFXLibrary/DoubleJumpSFX.play()

	
	$AnimatedSprite.flip_h = flip_h()
	  
	move_body()


func process_hitstun( delta ):
	#Move myself.
	move_body()
	
	#I am invincible until the hitstun
	#wears off.
	$Hurtbox.is_activated( false )
	$DashHitbox.is_activated( false )
	
	hitstun_left -= delta
	if hitstun_left <= 0 :
		hitstun_left = HITSTUN_WAIT
		fsm_state = "Default"
		if dash_lasted > 0 :
			self.position.x += DASH_PUSHBACK * sign(-dash_direction)
			dash_lasted = 0
		$Hurtbox.is_activated( true )


func slope():
	#Returns the slope's angle.
	var slope = Vector2( 0,0 )
	if $FloorLeft.is_colliding() :
		slope = $FloorLeft.get_collision_normal()
	
	elif $FloorRight.is_colliding() :
		slope = $FloorRight.get_collision_normal()
	

	return slope.rotated( 1.570796 ).angle() * int( allow_slope )


func is_snowman():
	return