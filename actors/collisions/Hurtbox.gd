extends "res://actors/collisions/Colbox.gd"


#All you have to do to use these
#scenes is instance them as a child of
#the physics body you want to have the box.


func collided( area ):
	pushback( area )
	
	area.hit( self )


func hurt( damage, hitbox ):
	if is_active :
		get_parent().emit_signal( "damage", damage )