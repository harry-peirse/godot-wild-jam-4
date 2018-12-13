extends Area2D

onready var t = get_node("Timer")


func _on_Fountain_area_entered(area):
	$Fountain/FountainDialogue.visible = true
	t.set_wait_time(4)
	t.start()
	yield(t, "timeout")
	$Fountain/FountainDialogue.visible = false


func _on_Fountain_area_exited(area):
	$Fountain/FountainDialogue.visible = false
