extends Camera2D



func _process(delta):
	if current == true :
		Pause.position = self.get_camera_screen_center()