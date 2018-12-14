extends "res://actors/enemy/EnemyInterface.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	walk_speed += 50
	
	falloff_distance = 12
	
	$Falloff.position.x = falloff_distance