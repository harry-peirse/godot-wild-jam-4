extends "res://actors/enemy/Enemy.gd"


#Use this to handle animations.
#Possible animations are:

#Die
#Falling
#Hit
#Idle
#Jump (not programmed yet)
#Walk


func _process(delta):
	$Sprite2.flip_h = flip_h()


func _ready():
	self.connect( "change_anim", self, "change_anim" )


func change_anim( new_anim ):
	pass