extends "res://actors/character/snowman/Snowman.gd"


func _ready():
	self.connect( "double_jump", self, "double_jump" )
	self.connect( "dash", self, "dash" )
	self.connect( "just_landed", self, "just_landed" )
	self.connect( "change_anim", self, "change_anim" )


func change_anim( new_anim ):
	if $AnimatedSprite.animation != new_anim :
		$AnimatedSprite.animation = new_anim
	$AnimatedSprite.play()


func dash( is_dashing : bool ):
	if is_dashing :
		$DashFX.emitting = true
	else:
		$DashFX.emitting = false


func double_jump():
	$DoubleJumpFX.emitting = true
	$DoubleJumpFX.restart()


func just_landed():
	$SFXLibrary/GroundImpactSFX.play()
	
	
	#Make the particle physics stop emitting.
	$DashFX.emitting = false
	$DoubleJumpFX.emitting = false