extends Node2D

signal burn_damage_taken

export var damage_per_second = 10
export var damage_interval = 1

func _ready():
	$DamageTimer.set_wait_time(damage_interval)	

func _on_Area2D_area_entered(actor):
	emit_signal("burn_damage_taken", damage_per_second)
	$DamageTimer.start()


func _on_DamageTimer_timeout():
	emit_signal("burn_damage_taken", damage_per_second)

func _on_Area2D_area_exited(area):
	$DamageTimer.stop()
