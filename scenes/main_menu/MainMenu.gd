extends Node2D


const PARALLAX_MAX = 768
const SANTA_HOUSE = 768 + (64 * 4)

var is_parallaxing = true

const TEXT_WAIT = 0.016667 *15
var text_time_current  = TEXT_WAIT


func _ready():
	Pause.enabled( false )
	
	#Flip the Snowman sprite.
	$Snowman/AnimatedSprite.flip_h = false


func _process(delta):
	#Game, you watch my Camera.
	$Camera2D2.current = true
	
	if Input.is_action_just_pressed( "enter" ) :
		is_parallaxing = false
	
	$TileMap.position.x += 2
	
	#Make the floor scroll.
	if is_parallaxing :
		
		if $TileMap.position.x >= PARALLAX_MAX :
			$TileMap.position.x = 0
	
	elif $TileMap.position.x >= SANTA_HOUSE :
		Pause.enabled( true )
		SceneBrowser.load_scene( "Intro" )
		Transition.change_scene()
	
	
	#Make text blink
	
	
	
	
	
	
	
	