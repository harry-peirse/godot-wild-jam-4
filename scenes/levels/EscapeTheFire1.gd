extends Node

const PARALLAX_BACKGROUND_SCROLL_SPEED = Vector2(-3,0);
const PARALLAX_FOREGROUND_SCROLL_SPEED = Vector2(-3,0);

export(float) var level_duration = 45 setget _set_level_duration

func _ready():
	_start_level()
	Music.play_track(Music.tracks.panic)
	$ParallaxBackground.set_ignore_camera_zoom(true)
	$Snowman/AnimatedSprite.play("running")
	
func _process(delta):
	$ParallaxBackground.set_scroll_offset($ParallaxBackground.scroll_offset + PARALLAX_BACKGROUND_SCROLL_SPEED)
	$ParallaxForeground.set_scroll_offset($ParallaxForeground.scroll_offset + PARALLAX_FOREGROUND_SCROLL_SPEED)
	
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
