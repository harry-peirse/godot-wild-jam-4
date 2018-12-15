extends Node2D

const CHAR_DESTINATION = 700
const CHAR_WALK_SPEED = 125

var waiting_for_start = true
var animating_character = false
var start_intro = false

func _process(delta):
	if waiting_for_start:
		_wait_for_enter_to_be_pressed()
	elif animating_character:
		_animate_character(delta)
	elif start_intro:
		_start_intro()
		
func _wait_for_enter_to_be_pressed():
	if Input.is_action_pressed("ConfirmButton") || Input.is_action_pressed("ui_accept"):
		$AnimatedSprite.play("Run")
		waiting_for_start = false
		animating_character = true

func _animate_character(delta):
	if $AnimatedSprite.position.x < CHAR_DESTINATION :
		$AnimatedSprite.position.x += CHAR_WALK_SPEED * delta
	else:
		animating_character = false
		start_intro = true

func _start_intro():
	SceneBrowser.load_scene("Intro")
	start_intro = false