extends Node2D

var pause : bool = true

#List of all buttons.
var button_array : Array = []

#This determines what button 
#we are highlighting.
var current_button = 0

var camera_center = CanvasItem


#Change the color of the 
#highlighted button.
const RED = Color( 1,0,0,1 )
const GREEN = Color( 0,1,0,1 )
const CHANGE_COLOR_WAIT_TIME = 0.01667 * 20
const BLUE = Color( 0,1,1,1 )

var color = [ BLUE, GREEN ]
var current_color = 0
var change_color_time = CHANGE_COLOR_WAIT_TIME


func _process(delta):
	if Input.is_action_just_pressed( "ui_cancel" ) :
		get_tree().paused = pause
		
		
		if pause == true :
			#Position myself into
			#the center of the screen.
			pause = false
			current_button = 0
			self.show()
		else:
			pause = true
			self.hide()
	
	if get_tree().paused :
		process_pause( delta )


func _ready():
	#Give the button array the buttons.
	button_array = [ $Continue, $Quit ]
	
	self.hide()


func process_pause( delta ):
	#This is what is called when the menu is showing.
	
	#Player made a decision in the menu.
	if Input.is_action_just_pressed( "ui_accept" ) :
		if current_button == 0 : #Continue
			
			get_tree().paused = pause
			self.hide()
			return
		else:
			get_tree().quit()
	
	#Handle selecting the above and bottom button.
	elif Input.is_action_just_pressed( "ui_up" ) :
		current_button -= 1
		
		if current_button < 0 :
			current_button = button_array.size() - 1

	
	elif Input.is_action_just_pressed( "ui_down" ):
		current_button += 1
		
		if current_button > button_array.size() - 1 :
			current_button = 0
	
	#Highlight the current button.
	for button in button_array :
		if button == button_array[ current_button ] :
			button.modulate = color[ current_color ]
		else:
			button.modulate = RED
	
	#Handle the blinking of the button.
	change_color_time -= delta
	if change_color_time <= 0 :
		change_color_time = CHANGE_COLOR_WAIT_TIME
		current_color += 1
		
		if current_color >= color.size() :
			current_color = 0
		
		
		
		
		