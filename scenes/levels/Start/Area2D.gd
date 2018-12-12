extends Area2D

var is_in_area
onready var t = get_node("Timer")
var bag_taken = false
var already = false

func _on_Area2D_area_entered(area):
	if(!bag_taken):
		$Dialogue1.visible = true
		$BagButton.visible = true
		is_in_area = true

func _on_Area2D_area_exited(area):
	if(!bag_taken):
		$Dialogue1.visible = false
		$BagButton.visible = false
		is_in_area = false
	
func _process(delta):
	if (is_in_area)&&(Input.is_key_pressed(KEY_E)&&(!bag_taken)&&(!already)):
		already = true
		$EButton.play()
		$Bag.visible=false
		$Bag/StaticBody2D/CollisionShape2D.disabled = true
		$BagButton.visible =false
		$Dialogue1.visible=false
		t.set_wait_time(.5)
		t.start()
		yield(t, "timeout")
		bag_taken=true
		



func _on_NextScene_area_entered(area):
	if(bag_taken):
		get_node("/root/SceneBrowser").load_scene("OutsideDungeon1")
