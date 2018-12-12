extends Node

export(float) var level_duration = 60 setget _set_level_duration

func _ready():
	_start_level()
	Music.play_track(Music.tracks.panic)
	
func _start_level():
	$LevelDurationTimer.set_wait_time(level_duration)
	$LevelDurationTimer.set_one_shot(true)
	$LevelDurationTimer.start()
	
func _on_LevelDurationTimer_timeout():
	_clean_up()
	
func _clean_up():
	$LevelDurationTimer.queue_free()
	
func _set_level_duration(value):
	level_duration = value

func _on_ObstacleSpawner_new_obstacle(obstacle):
	add_child(obstacle)
