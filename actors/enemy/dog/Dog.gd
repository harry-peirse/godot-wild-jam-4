extends "res://actors/enemy/EnemyInterface.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.

var been_footstooled : bool = false


func _ready():
	walk_speed += 50
	
	falloff_distance = 12
	
	$Falloff.position.x = falloff_distance


func foot_stooled() :
	fsm_state = "Pushed"
	can_handle_physics = false
	is_damaged = true
	velocity.x = 0
	velocity.y = 200
	
	#After the footstool, attack the player
	been_footstooled = true
	
	#Why do I have to do this to make it work?
	if health <= 0 :
		ready_to_die()


func process_attack( delta ):
	#If I have not been footstooled,
	#ignore this.
	if been_footstooled == false :
		fsm_state = "Chase"
		process_chase( delta )
		return
	
	#Jump to get the opponent.
	move_body()
	
	#Play the correct animation.
	emit_signal( "change_anim", "Attack" )
	
	#If I have landed, than the
	#state is finished.
	if on_floor :
		$AnimSprite.rotation -= deg2rad( 90 )
		if chase_object != null :
			fsm_state = "Chase"
		else:
			fsm_state = "Wander"


func process_pushed( delta ):
	#Spaghetti code for the win.
	if is_damaged:
		emit_signal( "change_anim", "Hit" )
	else:
		emit_signal( "change_anim", "Idle" )
	
	#Does this fix the rotation issue?
	$AnimSprite.rotation_degrees = 0
	
	
	pushback_left -= delta
	
	move_body()
	
	if pushback_left <= 0 :
		can_handle_physics = true
		is_damaged = false
		pushback_left = PUSHBACK_WAIT
		
		#Why.
		emit_signal( "change_anim", "Running" )
		if been_footstooled && on_floor :
			$AnimSprite.flip_h = false
			$AnimSprite.rotation += deg2rad( 90 )
			fsm_state = "Attack"
			jump()
		
		elif chase_object != null :
			fsm_state = "Chase"
		else:
			fsm_state = "Wander"






