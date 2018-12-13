extends "res://actors/collisions/Colbox.gd"


func collided( area ):
	area.get_parent().emit_signal( "foot_stomped", Vector2( 0, -700 ) )


func make_layer_active( boolean : bool ):
	self.set_collision_layer_bit( FOOTSTOOL_LAYER, boolean )