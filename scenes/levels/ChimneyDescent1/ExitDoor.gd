extends Area2D

var is_in_area
onready var t = get_node("Timer")
var already = false

func _process(delta):
	if (is_in_area)&&(Input.is_key_pressed(KEY_E)&&(!already)):
		already=true
		$DoorSFX.play()
		t.set_wait_time(1)
		t.start()
		yield(t, "timeout")
		get_node("/root/SceneBrowser").load_scene("LivingRoom")

func _on_ExitDoor_area_entered(area):
	$Button.visible = true
	is_in_area = true


func _on_ExitDoor_area_exited(area):
	$Button.visible = false
	is_in_area = false