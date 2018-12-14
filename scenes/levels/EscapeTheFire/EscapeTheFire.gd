extends Node

export(int) var difficulty = 0
var level_duration = 45

var difficulty_config = {
		0: {
			 "scroll_speed_offset": 0,
			 "max_obstacle_type": 2,
			 "contains_air_obstacles": false,
			 "obstacle_damage_modifier": 0,
			 "duration": 25
			},
		1: {
			 "scroll_speed_offset": 0,
			 "max_obstacle_type": 3,
			 "contains_air_obstacles": false,
			 "obstacle_damage_modifier": 0,
			 "duration": 25
			},
		2: {
			 "scroll_speed_offset": 0,
			 "max_obstacle_type": 3,
			 "contains_air_obstacles": true,
			 "obstacle_damage_modifier": 0,
			 "duration": 25
			},
		3: {
			 "scroll_speed_offset": 0.2,
			 "max_obstacle_type": 3,
			 "contains_air_obstacles": true,
			 "obstacle_damage_modifier": 0,
			 "duration": 30
			},
		4: {
			 "scroll_speed_offset": 0.2,
			 "max_obstacle_type": 5,
			 "contains_air_obstacles": true,
			 "obstacle_damage_modifier": 0,
			 "duration": 30
			},
		5: {
			 "scroll_speed_offset": 0.3,
			 "max_obstacle_type": 5,
			 "contains_air_obstacles": true,
			 "obstacle_damage_modifier": 0,
			 "duration": 35
			},
		6: {
			 "scroll_speed_offset": 0.35,
			 "max_obstacle_type": 5,
			 "contains_air_obstacles": true,
			 "obstacle_damage_modifier": 0,
			 "duration": 40
			},
		7: {
			 "scroll_speed_offset": 0.40,
			 "max_obstacle_type": 5,
			 "contains_air_obstacles": true,
			 "obstacle_damage_modifier": 0,
			 "duration": 45
			},
		8: {
			 "scroll_speed_offset": 0.45,
			 "max_obstacle_type": 5,
			 "contains_air_obstacles": true,
			 "obstacle_damage_modifier": 0,
			 "duration": 45
			},
		9: {
			 "scroll_speed_offset": 0.5,
			 "max_obstacle_type": 5,
			 "contains_air_obstacles": true,
			 "obstacle_damage_modifier": 0,
			 "duration": 50
			},
		10: {
			 "scroll_speed_offset": 0.6,
			 "max_obstacle_type": 5,
			 "contains_air_obstacles": true,
			 "obstacle_damage_modifier": 0,
			 "duration": 55
			},					
		11: {
			 "scroll_speed_offset": 0.65,
			 "max_obstacle_type": 5,
			 "contains_air_obstacles": true,
			 "obstacle_damage_modifier": 0,
			 "duration": 60
			}						 
	}

const PARALLAX_BACKGROUND_SCROLL_SPEED = Vector2(-3,0);
const PARALLAX_FOREGROUND_SCROLL_SPEED = Vector2(-3,0);

var continue_scrolling = true;

func _ready():
	$ObstacleSpawner.max_obstacle_type = difficulty_config[difficulty].max_obstacle_type
	$ObstacleSpawner.spawn_sky_obstacles = difficulty_config[difficulty].contains_air_obstacles
	$ObstacleSpawner.obstacle_frequency_modifier = difficulty_config[difficulty].scroll_speed_offset
	level_duration = difficulty_config[difficulty].duration
	_start_level()
	Music.play_track(Music.tracks.panic)
	$Background/ParallaxBackground.set_ignore_camera_zoom(true)
	$Snowman/AnimatedSprite.play("running")
	
func _process(delta):
	if continue_scrolling:
		$Background/ParallaxBackground.set_scroll_offset($Background/ParallaxBackground.scroll_offset + PARALLAX_BACKGROUND_SCROLL_SPEED)
		$Background/ParallaxForeground.set_scroll_offset($Background/ParallaxForeground.scroll_offset + PARALLAX_FOREGROUND_SCROLL_SPEED)
	
func _start_level():
	$LevelDurationTimer.set_wait_time(level_duration)
	$LevelDurationTimer.set_one_shot(true)
	$LevelDurationTimer.start()
	
func _on_LevelDurationTimer_timeout():
	_clean_up()
	get_node("/root/SceneBrowser").load_scene("EscapeTheFireExit")
	
func _clean_up():
	$LevelDurationTimer.queue_free()
	
func _on_ObstacleSpawner_new_obstacle(obstacle):
	add_child(obstacle)
	
func _on_Snowman_lost_all_health():
	continue_scrolling = false
	_clean_up()
