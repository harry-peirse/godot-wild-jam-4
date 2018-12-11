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

var on_floor = false

var run_physics : bool = true


func handle_physics( delta ):
	if run_physics == false :
		return
	
	#Calculate velocity's y value.
	velocity.y = min( velocity.y + GRAVITY_ADD, GRAVITY_MAX )

	allow_slope = false
	if on_floor() && velocity.y >= 0:
		allow_slope = true
		velocity.y = 0

				
	$Ceiling.update()
	if $Ceiling.is_colliding() && velocity.y <= 0:
		velocity.y = 0



func on_floor():
	on_floor = false
	$FloorLeft.update()
	$FloorRight.update()
	
	if $FloorLeft.is_colliding() || $FloorRight.is_colliding():
		on_floor = true
		
	return on_floor


func move_body( move_by = velocity.rotated( slope() ) ):
	move_and_slide_with_snap( move_by , Vector2( 0, -1 ), FLOOR )


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

	
	
	
	
	
	