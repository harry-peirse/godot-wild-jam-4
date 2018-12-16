extends "res://actors/Health.gd"

const FLOOR = Vector2( 0,-1 )
const GRAVITY_ADD = 70
const GRAVITY_MAX = 600

signal change_anim #Possible anims:
	#die
	#falling
	#hit
	#idle
	#jump (not programmed yet)
	#Running
signal change_direction
signal flip_h
signal just_landed
signal foot_stomped
signal foot_stooled
signal pushback


#Determines the velocity
var velocity : Vector2 = Vector2( 0,0 )

#Slope handling.
var allow_slope = false #Fixes slopes messing with jumps.

var on_floor = false

var run_physics : bool = true

#This will allow us to get the same results from
#calculations even at different frame rates.
const FRAME = 0.016667
var time_passed = 0


func _process(delta):
	#Handle the frame rate.
	time_passed += delta
	while time_passed >= FRAME :
		process_frame( delta )
		time_passed -= FRAME


func _ready():
	self.connect( "pushback", self, "pushback" )
	self.connect( "foot_stomped", self, "foot_stomped" )
	self.connect( "foot_stooled", self, "foot_stooled" )


func been_hit( push : Vector2, damaged = false ):
	pass


func foot_stooled():
	#I am angry with a bug right now.
	pass


func flip_h():
	#Let sprites know to flip themselves.
	var signed = sign( velocity.x )
	if signed != 0 :
		if signed == 1 :
			emit_signal( "flip_h", true )
		else:
			emit_signal( "flip_h", false )


func foot_stomped( push : Vector2 ):
	self.velocity.y = 0
	velocity += push


func handle_physics( delta, can_run = true ):
	if run_physics == false :
		return
	
	#Calculate velocity's y value.
	velocity.y = min( velocity.y + GRAVITY_ADD, GRAVITY_MAX )

	allow_slope = false
	if on_floor() && velocity.y >= 0:
		if on_floor == false :
			emit_signal( "just_landed" )
		on_floor = true
		allow_slope = true
		velocity.y = 0
		
		#Determine if I am running or standing idle.
		if can_run == true :
			if abs(velocity.x) > 0 :
				emit_signal( "change_anim", "Running" )
			else:
				emit_signal( "change_anim", "Idle" )
	
	#If I am falling downward.
	elif velocity.y > 0:
		on_floor = false
		if can_run :
			emit_signal( "change_anim", "Falling" )
	
	#Else I am moving upwards
	else:
		on_floor = false
		if can_run :
			emit_signal( "change_anim", "Jumping" )

	#If I bop my head, stop traveling upwards.
	$Ceiling.update()
	if $Ceiling.is_colliding() && velocity.y <= 0:
		velocity.y = 0



func on_floor():
	var currently_on_floor = false
	$FloorLeft.update()
	$FloorRight.update()
	
	if $FloorLeft.is_colliding() || $FloorRight.is_colliding():
		currently_on_floor = true
		
	return currently_on_floor


func move_body( move_by = velocity.rotated( slope() ), delta = FRAME ):
	move_and_slide_with_snap( (move_by.rotated(slope()) / delta) * FRAME, Vector2( 0, -1 ), FLOOR )
	flip_h()


func process_frame( delta ):
	pass


func pushback( push : Vector2, damaged = false ):
	#Stop all movement so that pushback
	#can have an affect.
	velocity.x = 0
	if push.y != 0 :
		velocity.y = 0
	
	velocity += push
	
	been_hit( push, damaged )


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

	
	
	
	
	
	