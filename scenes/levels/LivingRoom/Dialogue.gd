extends Area2D

var in_area
var tree = false
onready var t = get_node("Timer")

func _on_Dialogue_area_entered(area):
	in_area = true
	if (!tree):
		$EButtonTree.visible = true

func _on_Dialogue_area_exited(area):
	in_area = false
	if(!tree):
		$EButtonTree.visible = true
	
func _process(delta):

	if(!tree)&&(Input.is_key_pressed(KEY_E))&&(in_area):
		tree =true
		$EButtonTree.visible = false
		$ButtonSFX.play()
		$Success.visible = true
		t.set_wait_time(2)
		t.start()
		yield(t, "timeout")
		get_node("/root/SceneBrowser").load_scene("OutsideDungeon1")
	