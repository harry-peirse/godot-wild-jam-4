extends "res://actors/physics/Physics.gd"


#When true, the enemy does not wander.
export var is_still = false

#How fast the enemy walks around when not
#in pursut.
export var walk_speed = 100

var fsm_state = {
	"Wander" : "wander",
}
var current_state = "Wander"

var direction = "Right"
var move_direction = 1


func _ready():
	self.connect( "lost_all_health", self, "queue_free" )


func _process(delta):
	handle_physics( delta )
	call( "process_" + fsm_state[ current_state ], delta )


func process_wander( delta ):
	#Flip to the other direction if a drop off 
	#is imminent.
	$Falloff.update()
	if $Falloff.is_colliding() == false :
		if direction == "Left":
			direction = "Right"
			move_direction = 1
		else:
			direction = "Left"
			move_direction = -1
		
	
	velocity.x = walk_speed * move_direction
	
	move_and_slide_with_snap( velocity, Vector2(0,0), FLOOR )
	
