extends "res://actors/collisions/Colbox.gd"


func collided( area ):
	area.hit()


func hurt( damage ):
	get_parent().emit_signal( "damage", damage )