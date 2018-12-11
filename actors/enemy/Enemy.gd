extends "res://actors/physics/Physics.gd"


#When true, the enemy does not wander.
export var is_still = false

#How fast the enemy walks around when not
#in pursut.
export var walk_speed = 100

var fsm_dict = {
	"Wander" : "wander",
}
var fsm_state = "Wander"

var direction = "Right"
var move_direction = 1
var ignore_falloff = false


func _ready():
	self.connect( "lost_all_health", self, "queue_free" )


func _process(delta):
	handle_physics( delta )
	call( "process_" + fsm_dict[ fsm_state ], delta )


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
