extends Area2D


func _on_Heat_area_entered(area):
	area.startFeelingHeat()


func _on_Heat_area_exited(area):
	area.stopFeelingHeat()
