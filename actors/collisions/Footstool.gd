extends "res://actors/collisions/Colbox.gd"


func collided( area ):
	area.get_parent().emit_signal( "foot_stomped", push_other )