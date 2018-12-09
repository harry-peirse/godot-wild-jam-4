extends "res://actors/collisions/Colbox.gd"

var damage = 20


func collided( area ):
	pushback( area )
	
	#Let the area know I have collided with it.
	area.hurt( damage )


func hit( hurtbox ):
	pass