extends "res://actors/Health.gd"

const FLOOR = Vector2( 0,-1 )
const GRAVITY_ADD = 70
const GRAVITY_MAX = 600

signal foot_stomped
signal foot_stooled
signal pushback

#Determines the velocity
var velocity : Vector2 = Vector2( 0,0 )

#Slope handling.
var allow_slope = false #Fixes slopes messing with jumps.

var run_physics : bool = true


func on_floor():
	var on_floor = false
	$FloorLeft.update()
	$FloorRight.update()
	
	if $FloorLeft.is_colliding() || $FloorRight.is_colliding():
		on_floor = true
		
	return on_floor


func handle_physics( delta ):
	if run_physics == false :
		return
	
	#Calculate velocity's y value.
	velocity.y = min( velocity.y + GRAVITY_ADD, GRAVITY_MAX )
				
	
#	if jump_held > 0 :
#		jump_held( delta )

	allow_slope = false
	if on_floor() && velocity.y >= 0:
		allow_slope = true
#		jump_held = 0
		velocity.y = 0
#		if Input.is_action_just_pressed( "jump" ) :
#			velocity.y = JUMP_STRENGTH
#			jump_held += delta
	
#	elif has_double_jump :
#			if Input.is_action_just_pressed( "jump" ) :
#				has_double_jump = false
#				velocity.y = DOUBLE_JUMP
#				current_state = state.JUMP
#				$AnimatedSprite.animation = "Jumping"
#				$DoubleJumpFX.emitting = true
				
	$Ceiling.update()
	if $Ceiling.is_colliding() && velocity.y <= 0:
#		jump_held = 0
		velocity.y = 0
	
#	if  velocity.x < 0 :
#		$AnimatedSprite.flip_h = true
#	if  velocity.x > 0 :
#		$AnimatedSprite.flip_h = false	


func run_physics( boolean : bool = true ):
	run_physics = boolean

	
func slope():
	#Returns the slope's angle.
	var slope = Vector2( 0,0 )
	if $FloorLeft.is_colliding() :
		slope = $FloorLeft.get_collision_normal()
	
	elif $FloorRight.is_colliding() :
		slope = $FloorRight.get_collision_normal()

	return slope.rotated( 1.570796 ).angle() * int( allow_slope )

	
	
	
	
	
	