extends Area2D

var in_range_E

func _ready():
	set_process(true)
	
func _on_Area2D2_area_entered(area):
	get_node(
	if(is_in_area):
		$EButton.visible = true
		$Press.visible = true
		in_range_E = true

func _on_Area2D2_area_exited(area):
	$EButton.visible = false
	$Press.visible = false
	in_range_E = false
	
func _process(delta):
	if (in_range_E)&&(Input.is_key_pressed(KEY_E)):
		get_node("/root/SceneBrowser").load_scene("Start")


