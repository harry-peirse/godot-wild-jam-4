extends "res://actors/collisions/Colbox.gd"

#All you have to do to use these
#scenes is instance them as a child of
#the physics body you want to have the box.


var damage = 20


func collided( area ):
	pushback( area )

	#Let the area know I have collided with it.
	area.hurt( damage, self )


func hit( hurtbox ):
	pass