extends Area2D

var is_in_area

func _on_Area2D_area_entered(area):
	$Dialogue1.visible = true
	is_in_area = true
	
func _on_Area2D_area_exited(area):
	is_in_area = false
	

func _process(delta):
	if (is_in_area)&&(Input.is_key_pressed(KEY_E)):
		$Dialogue1.visible = false
		$Dialogue2.visible = true
		