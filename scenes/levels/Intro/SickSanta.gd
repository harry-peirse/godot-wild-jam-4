extends Area2D


func _on_Area2D_area_entered(area):
	$Dialogue.visible = true


func _on_Area2D_area_exited(area):
	$Dialogue.visible = false
