extends Node

var emitObstacles = true
var startTime = 0

const NUMBER_OF_GROUND_OBSTACLE_TYPES = 4
const GROUND_OBSTACLE_FREQUENCY_MIN_VARIANCE = 0
const GROUND_OBSTACLE_FREQUENCY_MAX_VARIANCE = 0.5
const SKY_OBSTACLE_SPAWN_PROBABILITY = 0.55
const GROUND_OBSTACLE_SPAWN_COORDINATES = Vector2(1125, 530)
const LOW_AIR_SPAWN_COORDINATES = Vector2(1125, 650)

export(float) var ground_obstacle_frequency = 1.5 setget _set_ground_obstacle_frequency
export(float) var sky_obstacle_frequency = 6 setget _set_sky_obstacle_frequency
export(float) var level_duration = 90 setget _set_level_duration

var obstacle_scene = preload("res://actors/enemy/Obstacle.tscn")

func _ready():
	randomize()
	_start_level()
	
func _start_level():
	$LevelDurationTimer.set_wait_time(level_duration)
	$LevelDurationTimer.set_one_shot(true)
	$LevelDurationTimer.start()
	$GroundObstacleTimer.set_wait_time(ground_obstacle_frequency)
	$GroundObstacleTimer.start()
	$SkyObstacleTimer.set_wait_time(sky_obstacle_frequency)
	$SkyObstacleTimer.start()
	
func _emit_ground_obstacle():
	var obstacle_choice = randi() % NUMBER_OF_GROUND_OBSTACLE_TYPES
	prints("SCORCHED EARTH", obstacle_choice)
	var obstacle = obstacle_scene.instance()
	add_child(obstacle)
	obstacle.position = GROUND_OBSTACLE_SPAWN_COORDINATES
	#obstacle.set_linear_velocity(Vector2(OBJECT_VELOCITY, 0))
	$GroundObstacleTimer.set_wait_time(ground_obstacle_frequency + rand_range(GROUND_OBSTACLE_FREQUENCY_MIN_VARIANCE, GROUND_OBSTACLE_FREQUENCY_MAX_VARIANCE))
	pass
	
func _emit_sky_obstacle():
	var chance = rand_range(0, 1)
	print(chance)
	if chance <= SKY_OBSTACLE_SPAWN_PROBABILITY:
		print("FIRE IN THE SKY")
	pass
	
func _on_LevelDurationTimer_timeout():
	print("LEVEL COMPETED")
	emitObstacles = false
	_clean_up()
	pass
	
func _clean_up():
	$LevelDurationTimer.queue_free()
	$GroundObstacleTimer.stop()
	$GroundObstacleTimer.queue_free()
	$SkyObstacleTimer.stop()
	$SkyObstacleTimer.queue_free()
	
func _set_ground_obstacle_frequency(value):
	ground_obstacle_frequency = value
	
func _set_sky_obstacle_frequency(value):
	sky_obstacle_frequency = value	
	
func _set_level_duration(value):
	level_duration = value