extends Node

signal health
signal scale
signal low_health
signal dead

const LOW_HEALTH_AMOUNT = 20

var current_health = 100
var current_scale = 1

func change_health( new_health ):
	current_health = new_health
	
	if current_health == 0:
		emit_signal("dead")
	elif current_health <= LOW_HEALTH_AMOUNT:
		emit_signal("low_health")

func _on_get_health():
	emit_signal("health", current_health)

func _on_get_scale():
	emit_signal("scale", current_health)