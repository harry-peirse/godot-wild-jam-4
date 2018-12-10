extends "res://actors/collisions/Colbox.gd"


export var damage = 20


func collided( area ):
	area.get_parent().emit_signal( "damage", damage )
	area.get_parent().emit_signal( "footstooled" )