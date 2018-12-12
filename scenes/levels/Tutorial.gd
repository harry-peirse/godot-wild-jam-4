extends Node

onready var t = get_node("Timer")

func _ready():
	$Running.visible = true
	t.set_wait_time(2)
	t.start()
	yield(t, "timeout")
	$Running.visible = false
	$Jump.visible = true
	t.set_wait_time(2)
	t.start()
	yield(t, "timeout")
	$Jump.visible = false
	$DoubleJump.visible = true
	t.set_wait_time(2)
	t.start()
	yield(t, "timeout")
	$DoubleJump.visible = false
	$Dash.visible = true
	t.set_wait_time(2)
	t.start()
	yield(t, "timeout")
	$Dash.visible = false
	