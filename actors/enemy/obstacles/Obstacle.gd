extends Node2D

signal hit_obstacle

const OBJECT_SPEED = 300

var direction = Vector2(-1, 0)
export var damage_amount = 10

func _process(delta):
	position += OBJECT_SPEED * direction * delta
	
	if position.x < 0:
		queue_free()
		
func _on_RigidBody2D_area_entered(actor):
	actor.get_parent().been_hit(Vector2(0,0), true)
	pass # Replace with function body.
