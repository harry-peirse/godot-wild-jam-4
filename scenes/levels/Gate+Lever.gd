extends Area2D

onready var t = get_node("Timer")
var in_area = false

func _on_GateLever_area_entered(area):
	in_area=true
	$Button.visible = true


func _on_GateLever_area_exited(area):
	in_area=false
	$Button.visible = true
	
func _process(delta):
	if (in_area)&&(Input.is_action_just_pressed("ConfirmButton")):
		$Gate.play("Open")
		$Lever.play("Switch")
		$Gate/StaticBody2D/CollisionShape2D.disabled =true
		t.set_wait_time(1)
		t.start()
		yield(t, "timeout")