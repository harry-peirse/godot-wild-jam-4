extends Node2D

var pause : bool = true


func _process(delta):
	if Input.is_action_just_pressed( "ui_cancel" ) :
		get_tree().paused = pause
		
		if pause == true :
			pause = false
		else:
			pause = true