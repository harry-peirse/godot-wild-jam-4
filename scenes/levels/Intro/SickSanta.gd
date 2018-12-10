extends Area2D

var is_in_area
var in_range_E
var dialogue_end = false
var dialogue_counter = 1
var once = true

func _ready():
	set_process_input(true)
	
func _on_Area2D_area_entered(area):
	$Dialogue1.visible = true
	is_in_area = true
	
func _on_Area2D_area_exited(area):
	is_in_area = false
	
func _on_PressE_area_entered(area):
	if(dialogue_end == true):
		$PressE/EButton.visible = true
		$PressE/Press.visible = true
		in_range_E = true

func _on_PressE_area_exited(area):
	if(dialogue_end == true):
		$PressE/EButton.visible = false
		$PressE/Press.visible = false
		in_range_E = false
	
func _process(delta):
	if (is_in_area)&&(Input.is_action_just_pressed("ConfirmButton")):
		if dialogue_counter==1:
			$Dialogue1.visible = false
			$Dialogue2.visible = true
			dialogue_counter = 2
		elif dialogue_counter==2:
			$Dialogue2.visible = false
			$Dialogue3.visible = true
			dialogue_counter = 3
		elif dialogue_counter==3:
			$Dialogue3.visible = false
			$Dialogue4.visible = true
			dialogue_counter = 4
		elif dialogue_counter==4:
			$Dialogue4.visible = false
			$Dialogue5.visible = true
			dialogue_counter = 5
		elif dialogue_counter==5:
			$Dialogue5.visible = false
			$Dialogue6.visible = true
			dialogue_counter = 6
		elif dialogue_counter==6:
			$Dialogue6.visible = false
			$Dialogue7.visible = true
			dialogue_counter = 7
			dialogue_end = true
	if (in_range_E)&&(Input.is_key_pressed(KEY_E))&&(dialogue_end):
		get_node("/root/SceneBrowser").load_scene("Start")
	

