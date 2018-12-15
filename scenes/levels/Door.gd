extends Area2D

var in_area
var already
onready var t = get_node("Timer")

func _on_Door_area_entered(area):
	if(!already):
		in_area = true
		$Button_Sprite.visible = true


func _on_Door_area_exited(area):
	if(!already):
		in_area = false
		$Button_Sprite.visible = false
		
func _process(delta):
	if (!already)&&(Input.is_action_just_pressed("ConfirmButton")&&(in_area)):
		already = true
		$Animated_Door_Sprite/DoorSFX.play()
		$Animated_Door_Sprite.play()
		t.set_wait_time(1)
		t.start()
		yield(t, "timeout")
		get_node("/root/SceneBrowser").load_scene("LivingRoom")
