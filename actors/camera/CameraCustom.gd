extends Camera2D


func _process(delta):
	if current == true :
		Pause.position = self.get_camera_screen_center()
	
	limit_bottom = 10000
	limit_right = 10000
	limit_left = -10000
	limit_top = -10000



func _ready():
	limit_bottom = 10000
	limit_right = 10000
	