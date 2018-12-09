extends "res://actors/collisions/Colbox.gd"


#How much the hitbox should be pushed back.
#export var pushback = 0


func collided( area ):
	pushback( area )
	
	area.hit( self )


func hurt( damage, hitbox ):
	get_parent().emit_signal( "damage", damage )