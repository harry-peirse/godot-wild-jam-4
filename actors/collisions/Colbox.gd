extends Area2D


#Base script for hitbox and hurtbox.
var timer_duration = 2 #In seconds.

#If false, start free_timer to eventually queue_free.
var permanent = true


func _ready():
	#Queue_free myself after a select amount of time passes.
	if permanent != true :
		var free_timer = Timer.new()
		free_timer.autostart = false
		free_timer.one_shot = true
		free_timer.connect( "timeout", self, "queue_free" )
		free_timer.wait_time = timer_duration
		call_deferred( "add_child", free_timer )
		free_timer.start( timer_duration )


func create( relative_position, size : float = 10 ):
	var circle = CircleShape2D.new()
	circle.radius = size
	
	var col_shape = CollisionShape2D
	col_shape.shape = circle
	
	self.call_deferred( "add_child", col_shape )
	
	
	
	