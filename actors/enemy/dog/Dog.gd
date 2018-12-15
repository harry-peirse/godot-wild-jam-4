extends "res://actors/enemy/EnemyInterface.gd"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.

var been_footstooled : bool = false

var let_run = true


func _ready():
	
	self.connect( "change_anim", self, "check_anim" )
	
	walk_speed += 50
	
	falloff_distance = 12
	
	$Falloff.position.x = falloff_distance


func been_hit( push : Vector2, damaged = false):
	#Eventually play the correct animation.
	fsm_state = "Pushed"
	velocity = push
	can_handle_physics = false
	is_damaged = damaged
	$Footstool.is_activated( true )


func check_anim( new_anim ):
	#Check the anim so we know if we should rotate
	#it or not.
	if new_anim == "Attack" :
		fsm_state = "Attack"
		if direction == "Right" :
			$AnimSprite.rotation_degrees = 90
			$AnimSprite.flip_h = false
			$AnimSprite.flip_v = true
			
		else:
			$AnimSprite.rotation_degrees = -90
		
		
	else:
		$AnimSprite.rotation_degrees = 0
		$AnimSprite.flip_v = false


func flip_sprite( boolean ):
	#Flip only when animation state is not attack.
	if fsm_state == "Attack" :
		return
	
	$AnimSprite.flip_h = boolean


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
	#Jump to get the opponent.
	move_body()
	
	#If I have landed, than the
	#state is finished.
	if on_floor :
		let_run = true
		$Footstool.is_activated( true )
		$AnimSprite.rotation = 0
		if chase_object != null :
			fsm_state = "Chase"
		else:
			fsm_state = "Wander"


func process_frame(delta):
	#Prevent the enemy from glitch
	#jumping super high.
	if velocity.y <= JUMP_STRENGTH :
		velocity.y = JUMP_STRENGTH
	
	if is_alive :
		if can_handle_physics :
			handle_physics( delta, let_run )
	call( "process_" + fsm_dict[ fsm_state ], delta )


func process_pushed( delta ):
	#Spaghetti code for the win.
	let_run = true
	
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
		
		if been_footstooled && on_floor :
			fsm_state = "Attack"
			$Footstool.is_activated( false )
			emit_signal( "change_anim", "Attack" )
			jump()
			been_footstooled = false
			let_run = false
			return
		
		emit_signal( "change_anim", "Running" )
		
		if chase_object != null :
			fsm_state = "Chase"
		else:
			fsm_state = "Wander"





