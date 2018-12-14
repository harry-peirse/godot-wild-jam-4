extends "res://actors/character/snowman/SnowmanInterface.gd"



func _process(delta):
	if on_floor :
		$AnimatedSprite.animation = "Running"