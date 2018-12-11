extends Area2D

var in_area
var tree = false

func _on_Dialogue_area_entered(area):
	in_area = true
	if (!tree):
		$EButtonTree.visible = true

func _on_Dialogue_area_exited(area):
	in_area = false
	if(!tree):
		$EButtonTree.visible = true
	
func _process(delta):
	if(tree)&&(Input.is_key_pressed(KEY_E))&&(in_area):
		get_node("/root/SceneBrowser").load_scene("Start")
		
	if(!tree)&&(Input.is_key_pressed(KEY_E))&&(in_area):
		$EButtonTree.visible = false
		$Success.visible = true
		$EButtonDialogue.visible = true
		tree = true
	