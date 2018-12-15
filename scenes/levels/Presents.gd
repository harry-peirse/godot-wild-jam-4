extends Node2D

var in_area
var already

func _process(delta):
	if(Input.is_key_pressed(KEY_E))&&(in_area)&&(!already):
		visible = true
		already =true

func _on_Dialogue_area_entered(area):
	in_area = true

func _on_Dialogue_area_exited(area):
	in_area = false
