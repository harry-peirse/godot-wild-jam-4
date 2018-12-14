extends Node

onready var t = get_node("Timer")

var L1_area = false
var L1_done = false

var L2_area = false
var L2_done = false

var gate_done = false
	
func _process(delta):
	if (L1_area)&&(Input.is_action_just_pressed("ConfirmButton")&&(!L1_done)):
		L1_done = true
		$Lever1/Button.visible = false
		$Lever1/Lever.play("Switch")
		$LeverSFX.play()
		
	if(L2_area)&&(Input.is_action_just_pressed("ConfirmButton")&&(!L2_done)):
		L2_done = true
		$Lever2/Button.visible = false
		$Lever2/Lever.play("Switch")
		$LeverSFX.play()
		$Lever2/Slope.play("Surface")
		$Lever2/Slope/SlopeSFX.play()
		$Lever2/Slope/StaticBody2D/CollisionShape2D.disabled=false
		
	if(L1_done)&&(L2_done)&&(!gate_done):
		gate_done=true
		t.set_wait_time(1)
		t.start()
		yield(t, "timeout")
		$Gate.play("Open")
		$Gate/GateSFX.play()
		t.set_wait_time(1.5)
		t.start()
		yield(t, "timeout")
		$Gate/StaticBody2D/CollisionShape2D.disabled =true
		
	if(L1_done)||(L2_done):
		$LockedDialogue.visible = false
		

func _on_Lever1_area_entered(area):
	if(!L1_done):
		L1_area=true
		$Lever1/Button.visible = true


func _on_Lever1_area_exited(area):
	if(!L1_done):
		L1_area=false
		$Lever1/Button.visible = true


func _on_Lever2_area_entered(area):
	if(!L2_done):
		L2_area=true
		$Lever2/Button.visible = true


func _on_Lever2_area_exited(area):
	if(!L2_done):
		L2_area=false
		$Lever2/Button.visible = false
