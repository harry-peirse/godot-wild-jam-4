extends "res://actors/character/snowman/Snowman.gd"


func _ready():
	self.connect( "just_landed", self, "just_landed" )
	self.connect( "change_anim", self, "change_anim" )


func change_anim( new_anim ):
	if $AnimatedSprite.animation != new_anim :
		$AnimatedSprite.animation = new_anim
	$AnimatedSprite.play()


func just_landed():
	$SFXLibrary/GroundImpactSFX.play()