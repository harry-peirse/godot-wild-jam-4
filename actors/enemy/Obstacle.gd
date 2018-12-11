extends Node2D

const OBJECT_SPEED = 300

var direction = Vector2(-1, 0)

func _process(delta):
	position += OBJECT_SPEED * direction * delta
	
	if position.x < 0:
		print("xD")
		queue_free()