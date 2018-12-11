extends "res://actors/physics/Physics.gd"


#When true, the enemy does not wander.
export var is_still = false

#How fast the enemy walks around when not
#in pursut.
export var walk_speed = 100

#How fast the enemy runs after sighting the
#player.
export var chase_speed = 250

#Determines if I can spot the snowman behind myself.
export var see_behind = true

#Chase the object.
var chase_object

var fsm_dict = {
	"Wander" : "wander",
	"Chase" : "chase",
	"Pushed" : "pushed"
}
var fsm_state = "Wander"

var direction = "Right"
var move_direction = 1
var ignore_falloff = false

#Knockback variables.
const PUSHBACK_WAIT = 0.011167 * 20
var pushback_left = PUSHBACK_WAIT


func _ready():
	self.connect( "lost_all_health", self, "queue_free" )


func _process(delta):
	handle_physics( delta )
	call( "process_" + fsm_dict[ fsm_state ], delta )


func been_hit( push : Vector2, damaged = false):
	#Eventually play the correct animation.
	fsm_state = "Pushed"
	velocity = push


func chase_snowman( snowman ):
	if snowman == null :
		chase_object = null
		fsm_state = "Wander"
		return
	
	#Eventually check if player is behind me.
	#Right now just set chase_object to snowman.
	chase_object = snowman
	fsm_state = "Chase"


func process_chase( delta ):
	#Chase after the Snowman.
	var chase_after = chase_speed
	chase_after *= clamp( chase_object.global_position.x - self.global_position.x, -1, 1 )
	velocity.x = chase_after
	move_body()


func process_pushed( delta ):
	pushback_left -= delta
	
	move_body()
	
	if pushback_left <= 0 :
		pushback_left = PUSHBACK_WAIT
		if chase_object != null :
			fsm_state = "Chase"
		else:
			fsm_state = "Wander"


func process_wander( delta ):
	#Don't wander if set to still.
	if is_still :
		return
	
	#Flip to the other direction if a drop off 
	#is imminent.
	$Falloff.update()
	if ignore_falloff :
		if $Falloff.is_colliding() :
			ignore_falloff = false
	
	elif( $Falloff.is_colliding() == false &&
	on_floor ):
		if direction == "Left":
			direction = "Right"
			move_direction = 1
			$Falloff.position.x = -20
		else:
			direction = "Left"
			move_direction = -1
			$Falloff.position.x = 20
		
		#Wait until I get past this falloff
		#before turning around.
		ignore_falloff = true
	
	if on_floor == true :
		velocity.x = walk_speed * move_direction
		
	#Don't move if in air.
	else :
		velocity.x = 0
	
	move_body()




