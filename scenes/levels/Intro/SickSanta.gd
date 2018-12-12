extends Area2D

var is_in_area
var in_range_E
var dialogue_end = false
var dialogue_counter = 1
var once = true
onready var t = get_node("Timer")
var already = false

func _ready():
	set_process_input(true)
	
func _on_Area2D_area_entered(area):
	$Dialogue1.visible = true
	$DialogueButton.visible = true
	$LightningDialogue.visible = true
	is_in_area = true
	
func _on_Area2D_area_exited(area):
	is_in_area = false
	
func _on_PressE_area_entered(area):
	if(dialogue_end == true):
		$PressE/EButton.visible = true
		in_range_E = true

func _on_PressE_area_exited(area):
	if(dialogue_end == true):
		$PressE/EButton.visible = false
		in_range_E = false
	
func _process(delta):
	if (is_in_area)&&(Input.is_action_just_pressed("ConfirmButton")):
		if dialogue_counter==1:
			$EButtonSFX.play()
			$Dialogue1.visible = false
			$Dialogue2.visible = true
			dialogue_counter = 2
		elif dialogue_counter==2:
			$EButtonSFX.play()
			$Dialogue2.visible = false
			$Dialogue3.visible = true
			dialogue_counter = 3
		elif dialogue_counter==3:
			$EButtonSFX.play()
			$Dialogue3.visible = false
			$Dialogue4.visible = true
			dialogue_counter = 4
		elif dialogue_counter==4:
			$EButtonSFX.play()
			$Dialogue4.visible = false
			$Dialogue5.visible = true
			dialogue_counter = 5
		elif dialogue_counter==5:
			$EButtonSFX.play()
			$Dialogue5.visible = false
			$Dialogue6.visible = true
			dialogue_counter = 6
		elif dialogue_counter==6:
			$EButtonSFX.play()
			$Dialogue6.visible = false
			$Dialogue7.visible = true
			dialogue_counter = 7
			dialogue_end = true
			$DialogueButton.visible = false
	if (in_range_E)&&(Input.is_key_pressed(KEY_E))&&(dialogue_end)&&(!already):
		already = true
		$Door.play("Door")
		$DoorSFX.play()
		t.set_wait_time(1)
		t.start()
		yield(t, "timeout")
		get_node("/root/SceneBrowser").load_scene("Start")
	

