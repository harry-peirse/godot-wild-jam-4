extends Node2D

var pause : bool = true

#List of all buttons.
var button_array : Array = []

#This determines what button 
#we are highlighting.
var current_button = 0

var camera_center = CanvasItem


func _process(delta):
	if Input.is_action_just_pressed( "ui_cancel" ) :
		get_tree().paused = pause
		
		
		if pause == true :
			#Position myself into
			#the center of the screen.
			pause = false
			current_button = 0
		else:
			pause = true
	
	if get_tree().paused :
		process_pause( delta )


func process_pause( delta ):
	if Input.is_action_just_pressed( "ui_accept" ) :
		if current_button == 0 : #Continue
			get_tree().paused = pause
			return
	
	elif Input.is_action_just_pressed( "ui_up" ) :
		current_button -= 1
		
		if current_button < 0 :
			current_button = button_array.size() - 1
	
	elif Input.is_action_just_pressed( "ui_down" ):
		current_button += 1
		
		if current_button > button_array.size() - 1 :
			current_button = 0




