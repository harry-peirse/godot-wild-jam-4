extends Area2D

var in_area
var already
var has_gate = true


func _ready():
	$Gate/Gate.connect( "animation_finished", self, "kill_gate" )

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
		if has_gate :
			has_gate = false
			$Gate/Gate.play()
		set_process( false )


func kill_gate():
	$Gate.queue_free()