extends "res://actors/collisions/Colbox.gd"





export var damage = 20


func collided( area ):
	area.get_parent().emit_signal( "damage", damage )
	area.get_parent().emit_signal( "foot_stooled" )


func make_layer_active( boolean ):
	self.set_collision_mask_bit( FOOTSTOOL_LAYER, boolean )