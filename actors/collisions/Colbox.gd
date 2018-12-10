extends Area2D

#Base script for hitbox and hurtbox.
var timer_duration = 2 #In seconds.

#If false, start free_timer to eventually queue_free.
var permanent = true

export var is_active = true
export var push_self = Vector2( 0,0 )
export var push_other = Vector2( 0,0 )


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
	#Calculate which side the object is on in the x asis.
	var signed = sign( self.global_position.x - object.global_position.x )
	if signed == 0 :
		signed = 1
	
	#Y axis
	var y_signed = sign( self.global_position.y - object.global_position.y )
	if y_signed == 0 :
		y_signed = 1
	
	#Now push my parent back.
#	get_parent().global_position.x += signed * pushback
#	get_parent().global_position.y += y_signed * pushback_y
	
	get_parent().emit_signal( "pushback", Vector2( push_self.x * signed, push_self.y * y_signed ) )
	var other = object.get_parent()
	other.emit_signal( "pushback", Vector2( push_other.x * -signed, push_other.y * - y_signed ) )


func set_duration( new_time ):
	timer_duration = new_time


