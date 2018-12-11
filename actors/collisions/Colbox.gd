extends Area2D

const PLAYER_LAYER = 1
const ENEMY_LAYER = 3

#Base script for hitbox and hurtbox.
var timer_duration = 2 #In seconds.

#If false, start free_timer to eventually queue_free.
var permanent = true

export var is_active = true
export var push_self = Vector2( 0,0 )
export var push_other = Vector2( 0,0 )


func _ready():
	self.connect( "area_entered", self, "collided" )
	
	is_activated(is_active)
	
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
	
	#De-activate activity in layer.
	make_layer_active( set_activate )


func make_layer_active( set_active ):
	pass


func pushback( object, is_damaged = false ):
	#Calculate which side the object is on in the x asis.
	var signed = sign(  object.global_position.x - self.global_position.x )
	if signed == 0 :
		signed = 1
	
	#Y axis
	var y_signed = sign( object.global_position.y - self.global_position.y )
	if y_signed == 0 :
		y_signed = 1
	
	var other = object.get_parent()
	var push = (push_other + object.push_self) * Vector2( signed, y_signed )
	other.emit_signal( "pushback", push, is_damaged )
	


func set_duration( new_time ):
	#Remove myself after a certain amount of time.
	timer_duration = new_time


