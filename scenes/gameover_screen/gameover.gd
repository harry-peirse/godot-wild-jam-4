#extends "res://screens/basic_screen.gd"
extends Node

var continue_chosen = true

const RED = Color( 1,0,0,1 )
const GREEN = Color( 0,1,0,1 )
const CHANGE_COLOR_WAIT_TIME = 0.01667 * 20
const BLUE = Color( 0,1,1,1 )

var color = [ BLUE, GREEN ]
var current_color = 0
var change_color_time = CHANGE_COLOR_WAIT_TIME


func _process(delta):
	self.position = get_node( "../../" ).get_camera_screen_center()
	
	#Center the camera just a bit better.
	self.position.x = self.position.x - 11
	
	
	if Input.is_action_just_pressed( "ui_right" ) :
		continue_chosen = true
	elif Input.is_action_just_pressed( "ui_left" ) :
		continue_chosen = false
	
	#Now actually highlight the buttons and
	#be ready to select them.
	change_color_time -= delta
	if change_color_time <= 0 :
		change_color_time = CHANGE_COLOR_WAIT_TIME
		current_color += 1
		if current_color >= color.size() :
			current_color = 0
	
	if continue_chosen :
		$Quit.modulate = RED
		
		$Continue.modulate = color[ current_color ]
	else:
		$Continue.modulate = RED
		
		$Quit.modulate = color[ current_color ]
	
	
	#If accept is pressed, perform what is
	#highlighted.
	if Input.is_action_just_pressed( "ui_accept" ):
		if continue_chosen :
			continue_pressed()
		#Quit if quit is hovered over.
		else:
			get_tree().quit()
		
		
func continue_pressed():
	#Please put continue logic inside here.
	SceneBrowser.load_scene( "OutsideDungeon1" )