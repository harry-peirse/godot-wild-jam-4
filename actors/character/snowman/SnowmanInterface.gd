extends "res://actors/character/snowman/Snowman.gd"

var is_running =false


func flip_sprite( boolean ):
	$AnimatedSprite.flip_h = boolean


func _ready():
	self.connect( "double_jump", self, "double_jump" )
	self.connect( "dash", self, "dash" )
	self.connect( "jump", self, "jumped_from_floor" )
	self.connect( "just_landed", self, "just_landed" )
	self.connect( "change_anim", self, "change_anim" )
	self.connect( "flip_h", self, "flip_sprite" )
	
	#What a hack to make snowman sprite to face 
	#right when level has just started.
	flip_sprite( true )

func change_anim( new_anim ):
	if $AnimatedSprite.animation != new_anim :
		$AnimatedSprite.animation = new_anim
	$AnimatedSprite.play()
	
	if($AnimatedSprite.animation == "Running")&&(!is_running):
		is_running=true
		print("active")
		$SFXLibrary/Running2.playing = true
	elif($AnimatedSprite.animation != "Running"):
		print("inactive")
		$SFXLibrary/Running2.playing =false
		is_running = false
		_running()


func _running():
	pass
	
	
func dash( is_dashing : bool ):
	if is_dashing :
		$DashFX.emitting = true
		$SFXLibrary/DashSFX.play()
	else:
		$DashFX.emitting = false


func double_jump():
	$DoubleJumpFX.emitting = true
	$DoubleJumpFX.restart()
	$SFXLibrary/DoubleJumpSFX.play()


func jumped_from_floor():
	$SFXLibrary/JumpSFX.play()
	

func just_landed():
	$SFXLibrary/GroundImpactSFX.play()
	
	
	#Make the particle physics stop emitting.
	$DashFX.emitting = false
	$DoubleJumpFX.emitting = false