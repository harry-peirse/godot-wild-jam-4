extends Area2D

#Base script for hitbox and hurtbox.
var timer_duration = 2 #In seconds.

#If false, start free_timer to eventually queue_free.
var permanent = true

export var is_active = true
export var pushback = 0


func _ready():
	self.connect( "area_entered", self, "collided" )
	
	is_activated( is_active )
	
	#Queue_free myself after a select amount of time passes.
	if permanent != true :
		var free_timer = Timer.new()
		free_timer.autostart = false
		free_timer.one_shot = true
		free_timer.connect( "timeout", self, "queue_free" )
		free_timer.wait_time = timer_duration
		call_deferred( "add_child", free_timer )
		free_timer.start( timer_duration )


func is_activated( set_activate : bool ):
	is_active = set_activate
	
	#Make myself disappear while collisions
	#are visible in game.
	for child in get_children() :
		child.visible = is_active


func pushback( object ):
	#Calculate which side the object is on.
	var signed = sign( self.global_position.x - object.global_position.x )
	if signed == 0 :
		signed = 1
	
	#Now push my parent back.
	get_parent().global_position.x += signed * pushback


func set_duration( new_time ):
	timer_duration = new_time


