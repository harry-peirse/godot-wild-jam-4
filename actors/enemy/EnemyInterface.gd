extends "res://actors/enemy/Enemy.gd"


#Use this to handle animations.
#Possible animations are:

#die
#falling
#hit
#idle
#jump (not programmed yet)
#walk


func _process(delta):
	$Sprite2.flip_h = flip_h()


func _ready():
	self.connect( "change_anim", self, "change_anim" )


func change_anim( new_anim ):
	pass