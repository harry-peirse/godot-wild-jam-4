extends Area2D

onready var t = get_node("Timer")
var in_area = false
var already = false

func _on_GateLever_area_entered(area):
	if(!already):
		in_area=true
		$Button.visible = true


func _on_GateLever_area_exited(area):
	if(!already):
		in_area=false
		$Button.visible = true
	
func _process(delta):
	if (in_area)&&(Input.is_action_just_pressed("ConfirmButton")&&(!already)):
		already = true
		$Button.visible = false
		$Lever.play("Switch")
		$Lever/LeverSFX.play()
		t.set_wait_time(1)
		t.start()
		yield(t, "timeout")
		$Gate.play("Open")
		$Gate/GateSFX.play()
		t.set_wait_time(1.5)
		t.start()
		yield(t, "timeout")
		$Gate/StaticBody2D/CollisionShape2D.disabled =true