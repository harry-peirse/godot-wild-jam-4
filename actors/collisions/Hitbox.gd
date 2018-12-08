extends "res://actors/collisions/Colbox.gd"

var damage = 20


func collided( area ):
	#Let the area know I have collided with it.
	area.hurt( damage )


func hit():
	get_parent().position.x -= 40