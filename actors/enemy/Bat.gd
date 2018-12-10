tool
extends "res://actors/Health.gd"

const SHORTEST_WAKE_UP_INTERVAL = 0;
const LONGEST_WAKE_UP_INTERVAL = 0.25;

var speed = 400
var time = 0.0

var start_position = Vector2()
var direction_scal = 1

export(float) var sine_amplitude = 80 setget _set_sine_amplitude
export(bool) var left_to_right = true setget _set_left_to_right
export(bool) var asleep = true setget _set_asleep


func _ready():
	start_position = position
	
func _physics_process(delta):
	if Engine.editor_hint:
		return
	if ! asleep:
		$AnimatedSprite.play("fly")
		if (left_to_right == true):
			direction_scal = 1
			$AnimatedSprite.flip_h = false
		else:
			direction_scal = -1
			$AnimatedSprite.flip_h = true
		time += delta
		position.x += speed * delta * direction_scal
		position.y =  start_position.y + sin(time * 10) * sine_amplitude
	else:
		$AnimatedSprite.play("sleep")	
		
func _set_sine_amplitude(value):
	sine_amplitude = value
	update()

func _set_left_to_right(value):
	left_to_right = value
	update()
	
func _set_asleep(value):
	asleep = value
	update()

func _awaken(body):
	randomize()
	var timer = Timer.new()
	timer.set_wait_time(rand_range(SHORTEST_WAKE_UP_INTERVAL, LONGEST_WAKE_UP_INTERVAL))
	timer.set_one_shot(true)
	self.add_child(timer)
	timer.start()	
	yield(timer, "timeout")
	asleep = false	
	
func _draw():
	if not Engine.editor_hint:
		return
		
	var points_array = PoolVector2Array()
	var time_step = 0.02
	for i in range(128):
		var time = time_step * i
		var new_point = Vector2(time * speed * direction_scal, sin(time * 10) * sine_amplitude)
		points_array.append(new_point)
	draw_polyline(points_array, Color(1.0,1.0,1.0), 2.0, true)
