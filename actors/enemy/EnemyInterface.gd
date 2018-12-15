extends "res://actors/enemy/Enemy.gd"


#Use this to handle animations.
#Possible animations are:

#Die
#Falling
#Hit
#Idle
#Jump (not programmed yet)
#Walk
var is_hit
var is_dead

func flip_sprite( boolean ):
	$AnimSprite.flip_h = boolean


func _ready():
	self.connect( "change_anim", self, "change_anim" )
	self.connect( "flip_h", self, "flip_sprite" )




func change_anim( new_anim ):
	if $AnimSprite.animation != new_anim :
		$AnimSprite.animation = new_anim
		
	#Hit
	if ($AnimSprite.animation == "Hit")&&(!is_hit):
		is_hit= true
		$SFX/Footstool.playing = true
	elif($AnimSprite.animation!="Hit"):
		is_hit=false
		$SFX/Footstool.playing=false
		
	#Die-Sound
	if($AnimSprite.animation == "Die")&&(!is_dead):
		is_dead = true
		$SFX/Death.playing = true