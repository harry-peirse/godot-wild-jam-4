extends "res://actors/collisions/Colbox.gd"

#All you have to do to use these
#scenes is instance them as a child of
#the physics body you want to have the box.


export var damage = 20


func collided( area ):
	pushback( area )

	#Let the area know I have collided with it.
	area.hurt( damage, self )


func hit( hurtbox ):
	pass


func make_layer_active( set_activate ):
	if get_parent().has_method( "is_player" ) :
		set_collision_mask_bit( ENEMY_LAYER, set_activate )
		
	else:
		set_collision_mask_bit( PLAYER_LAYER, set_activate )
		
		