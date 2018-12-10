extends Sprite

func _ready():
	set_process(true)
	
func _process(delta):
	if(Input.is_key_pressed(KEY_E)):
		get_node("/root/SceneBrowser").load_scene("Start")