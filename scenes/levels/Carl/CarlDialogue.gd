extends Area2D
var in_area
var counter = 1
onready var t = get_node("Timer")


func _process(delta):
	if (in_area)&&(Input.is_action_just_pressed("ConfirmButton")):
		if  counter==1:
			$Label1.visible = false
			$Label2.visible = true
			counter = 2
		elif counter==2:
			$Label2.visible = false
			$Label3.visible = true
			counter =3
		elif counter==3:
			$Label3.visible = false
			$Label4.visible = true
			$Button.visible = false
			counter = 4
		elif counter==4:
			$Label4.visible = false
			$Label5.visible = true
			counter = 5
			t.set_wait_time(10)
			t.start()
			yield(t, "timeout")
			get_node("/root/SceneBrowser").load_scene("Start")
		elif counter==5:
			get_node("/root/SceneBrowser").load_scene("Intro")
			
	

func _on_CarlDialogue_area_entered(area):
	in_area = true
	$Button.visible = true
	$Dialogue.visible = true
	$Label1.visible = true


func _on_CarlDialogue_area_exited(area):
	in_area = false
	$Button.visible = false
	$Dialogue.visible = false
	$Label1.visible = false

