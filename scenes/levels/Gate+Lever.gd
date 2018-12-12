extends Area2D

var is_in_area = false 
var already = false
onready var t = get_node("Timer")

func _on_GateLever_area_entered(area):
	if(!already):
		is_in_area = true
		$ButtonLever.visible = true

func _on_GateLever_area_exited(area):
	if(!already):
		is_in_area =false
		$ButtonLever.visible = false

func _process(delta):
	if(is_in_area)&&(Input.is_action_just_pressed("ConfirmButton")):
		already = true
		$ButtonLever.visible = false
		$Lever/LeverSFX.play()
		$Lever.play("Switch")
		t.set_wait_time(1)
		t.start()
		yield(t, "timeout")
		$Gate/GateSFX.play()
		$Gate.play("Open")
		$Gate/StaticBody2D/CollisionShape2D.disabled = true
