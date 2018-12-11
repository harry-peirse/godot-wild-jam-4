extends Area2D

var is_in_area
var already
onready var t = get_node("Timer")

func _on_Area2D_area_entered(area):
	$Dialogue1.visible = true
	$Dialogue2.visible = true
	is_in_area = true

func _on_Area2D_area_exited(area):
	$Dialogue1.visible = false
	$Dialogue2.visible = false
	is_in_area = false
	
func _process(delta):
	if (is_in_area)&&(Input.is_key_pressed(KEY_E)&&(!already)):
		already = true
		$EButton.play()
		t.set_wait_time(.5)
		t.start()
		yield(t, "timeout")
		get_node("/root/SceneBrowser").load_scene("OutsideDungeon1")


