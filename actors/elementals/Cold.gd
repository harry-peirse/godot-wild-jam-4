extends Area2D


func _on_Cold_area_entered(area):
	area.startFeelingCold()


func _on_Cold_area_exited(area):
	area.stopFeelingCold()
