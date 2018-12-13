extends Area2D

onready var t = get_node("Timer")

signal fountain_entered

func _on_Fountain_area_entered(actor):
	emit_signal("fountain_entered")
	$Fountain/FountainDialogue.visible = true
	t.set_wait_time(4)
	t.start()
	yield(t, "timeout")
	$Fountain/FountainDialogue.visible = false

func _on_Fountain_area_exited(actor):
	$Fountain/FountainDialogue.visible = false
