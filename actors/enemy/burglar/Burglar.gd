extends "res://actors/enemy/EnemyInterface.gd"


var shot = preload( "res://actors/enemy/burglar/Shot.tscn" )

#How long the animation is played
const SHOT_RECOIL = 0.016667 * 40
var shot_wait = SHOT_RECOIL
var cannot_fire = false


# Called when the node enters the scene tree for the first time.
func _ready():
	falloff_distance = 3
	
	$Falloff.position.x = falloff_distance


func process_attack( delta ):
	shot_wait -= delta
	
	if( shot_wait <= 0 ):
		shot_wait = SHOT_RECOIL
		fsm_state = "Chase"
		process_chase( delta )
		cannot_fire = false
		return
	
	if cannot_fire :
		return
	
	#Play the animation.
	emit_signal( "change_anim", "Attack" )
	
	#Shoot a gun round.
	var new_shot = shot.instance()
	
	new_shot.global_position = self.global_position
	
	#Tell shot which direction to travel
	var dir = round( chase_object.global_position.x - self.global_position.x )
	if dir == 0 :
		dir = -1
	dir = clamp( dir, -1, 1 )
	
	new_shot.set_direction( dir )
	
	#Instance the shot in parent to avoid shot
	#being moved with my movement.
	get_parent().call_deferred( "add_child", new_shot )
	
	#Do not fire a gun again.
	cannot_fire = true