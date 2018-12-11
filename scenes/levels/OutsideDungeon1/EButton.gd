extends Area2D

var is_in_area

func _process(delta):
	if (is_in_area)&&(Input.is_key_pressed(KEY_E)):
		get_node("/root/SceneBrowser").load_scene("ChimneyDescent1")

func _on_EButton_area_entered(area):
	$Button.visible = true
	is_in_area = true


func _on_EButton_area_exited(area):
	$Button.visible = false
	is_in_area = false
