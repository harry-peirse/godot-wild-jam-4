extends KinematicBody2D

#Signals are great for calling methods in
#physics objects. Godot does not crash if it
#attempts to emit a signal inside a body
#that does not exist.

#These are the constants that will always be
#affecting us.
const FLOOR = Vector2( 0,-1 )
const GRAVITY_ADD = 50
const GRAVITY_MAX = 300
const JUMP_STRENGTH = -300
const JUMP_STAGE_1 = 0.011167 * 5
const JUMP_STAGE_2 = 0.011167 * 8
const JUMP_STAGE_3 = 0.011167 * 10
const JUMP_STAGE_MAX = 3


#Determines the velocity
var velocity : Vector2 = Vector2( 0,0 )

#Use this to determine jump height.
var jump_held : float = 0
var jump_stage : int = 1
var jump_mod : Array = [ 0, -140, -200, -300 ]

#Determines how large the snowman is.
var size = 1
onready var original_col_extents = $Col.shape.extents
onready var original_sprite_scale = $Sprite.scale


func _process(delta):
	#Quick left right handling.
	velocity.x = (int( Input.is_action_pressed("ui_right") ) - 
	int( Input.is_action_pressed( "ui_left" ) ) ) * 200
	
	#Calculate velocity's y value.
	velocity.y = min( velocity.y + GRAVITY_ADD, GRAVITY_MAX )

	if jump_held > 0 :
		jump_held( delta )

	if on_floor() :
		jump_held = 0
		velocity.y = 0
		if Input.is_action_just_pressed( "jump" ) :
			velocity.y = JUMP_STRENGTH
			jump_held += delta
	
	move_and_slide_with_snap( velocity , Vector2( 0, -1 ), FLOOR )


func change_scale( new_scale : float ):
	#Change the size of the snowman
	#Eventually we will better handle scaling.
	$Col.shape.extents = original_col_extents * new_scale
	$Sprite.scale = original_sprite_scale * new_scale


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
	
	if $Floor1.is_colliding() || $Floor2.is_colliding():
		on_floor = true
	
	return on_floor