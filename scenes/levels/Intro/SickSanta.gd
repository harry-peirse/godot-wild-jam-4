extends Area2D

var is_in_area
var in_range_E
var dialogue_end = false

func _on_Area2D_area_entered(area):
	$Dialogue1.visible = true
	is_in_area = true
	
func _on_Area2D_area_exited(area):
	is_in_area = false
	
func _on_PressE_area_entered(area):
	if(dialogue_end):
		$PressE/EButton.visible = true
		$PressE/Press.visible = true
		in_range_E = true

func _on_PressE_area_exited(area):
	if(dialogue_end):
		$PressE/EButton.visible = false
		$PressE/Press.visible = false
		in_range_E = false
	
func _process(delta):
	if (is_in_area)&&(Input.is_key_pressed(KEY_E)):
		$Dialogue1.visible = false
		$Dialogue2.visible = true
		dialogue_end = true
	if (in_range_E)&&(Input.is_key_pressed(KEY_E))&&(dialogue_end):
		get_node("/root/SceneBrowser").load_scene("Start")
	

