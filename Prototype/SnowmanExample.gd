extends KinematicBody2D

#Signals are great for calling methods in
#physics objects. Godot does not crash if it
#attempts to emit a signal inside a body
#that does not exist.

#These are the constants that will always be
#affecting us.
const GRAVITY_ADD = 50
const GRAVITY_MAX = 300
const FLOOR = Vector2( 0,-1 )

#Determines the velocity
var velocity : Vector2 = Vector2( 0,0 )
var jump_held : float = 0 #Use this to determine jump height.

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
	
	#We are on the floor, start the timer to determine
	#if we are in the air.
#	if is_on_floor() :
#		on_floor = true
#		air_time = 0
#	elif air_time >= THREE_FRAME :
#		on_floor = false


	if on_floor() :
		self.modulate = Color( 0,0,0, 1 )
		jump_held = 0
		velocity.y = 0
		if Input.is_action_just_pressed( "jump" ) :
			velocity.y =  -900
			jump_held += 1
	
	else:
		self.modulate = Color( 1,1,1,1 )
	
	move_and_slide_with_snap( velocity , Vector2( 0, -1 ), FLOOR )


func change_scale( new_scale : float ):
	#Change the size of the snowman
	#Eventually we will better handle scaling.
	$Col.shape.extents = original_col_extents * new_scale
	$Sprite.scale = original_sprite_scale * new_scale


func on_floor():
	var on_floor = false
	$Floor1.update()
	$Floor2.update()
	
	if $Floor1.is_colliding() || $Floor2.is_colliding():
		on_floor = true
	
	return on_floor