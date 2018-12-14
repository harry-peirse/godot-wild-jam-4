extends Area2D

var in_area
var already

func _on_Lever2_area_entered(area):
	if(!already):
		in_area = true
		$Button.visible = true
	


func _on_Lever2_area_exited(area):
	if(!already):
		in_area = false
		$Button.visible = false	
	
	

func _process(delta):
	if (in_area)&&(Input.is_key_pressed(KEY_E)&&(!already)):
		already=true
		$Button.visible = false
		$Lever2.play()
		$Lever2/leverSFX.play()
		$Gate.play()