#extends "res://screens/basic_screen.gd"
extends Node

var continue_chosen = true


func _process(delta):
	self.position = get_node( "../../" ).get_camera_screen_center()
	
	#Center the camera just a bit better.
	self.position.x = self.position.x - 10