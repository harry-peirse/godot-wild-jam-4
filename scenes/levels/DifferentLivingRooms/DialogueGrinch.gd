extends Area2D

var in_area
var counter = 1
onready var t = get_node("Timer")

func _on_GrinchDialogue_area_entered(area):
	in_area = true
	$Button.visible = true
	$DialogueGrinch.visible = true
	$DialogueGrinch/Label1.visible = true


func _on_GrinchDialogue_area_exited(area):
	in_area = false
	$Button.visible = false
	$DialogueGrinch.visible = false
	$DialogueGrinch.visible = false

func _process(delta):
	if (in_area)&&(Input.is_action_just_pressed("ConfirmButton")):
		if  counter==1:
			$DialogueGrinch/Label1.visible = false
			$DialogueGrinch/Label2.visible = true
			counter = 2
		elif counter==2:
			$DialogueGrinch/Label2.visible = false
			$DialogueGrinch/Label3.visible = true
			counter =3
		elif counter==3:
			$DialogueGrinch/Label3.visible = false
			$DialogueGrinch/Label4.visible = true
			counter = 4
		elif counter == 4:
			get_node("/root/SceneBrowser").load_scene("OutsideDungeon1")
	
		