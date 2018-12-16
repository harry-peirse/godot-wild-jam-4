extends Node

func _ready():
	SceneBrowser.load_scene("KrampusFight")
#	Transition.fade_in()
	
	Music.play_track(Music.tracks.outside)
	if LevelManager.get_snowman_location() != null :
		$Snowman.global_position = LevelManager.get_snowman_location()
		$Snowman.global_position.y 

