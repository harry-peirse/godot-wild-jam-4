extends Area2D

var in_area
var already
onready var t = get_node("Timer")

func _on_Door_area_entered(area):
	if(!already):
		in_area = true
		$Button.visible = true


func _on_Door_area_exited(area):
	if(!already):
		in_area = false
		$Button.visible = false
		
func _process(delta):
	if (!already)&&(Input.is_action_just_pressed("ConfirmButton")&&(in_area)):
		already = true
		$Door/DoorSFX.play()
		$Door.play()
		t.set_wait_time(1)
		t.start()
		yield(t, "timeout")
		get_node("/root/SceneBrowser").load_scene("CarlsEnding")
