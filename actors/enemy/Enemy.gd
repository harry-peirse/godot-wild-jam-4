extends "res://actors/physics/Physics.gd"


const JUMP_STRENGTH = -800

#Prevent something random from getting played.
var can_handle_physics : bool = true


#When true, the enemy does not wander.
export var is_still = false

#How fast the enemy walks around when not
#in pursut.
export var walk_speed = 100

#How fast the enemy runs after sighting the
#player.
export var chase_speed = 250

#Determines if I can spot the snowman behind myself.
export var see_behind = true

#How far out the object should extend before
#turning because of a drop off
export var falloff_distance = 20

#Chase the object.
var chase_object

var fsm_dict = {
	"Wander" : "wander",
	"Chase" : "chase",
	"Pushed" : "pushed",
	"Die" : "die"
}
var fsm_state = "Wander"

var direction = "Right"
var move_direction = 1
var ignore_falloff = false

#Death last for this long.
var is_alive = true
var death_wait = 0.016667 * 120

#Knockback variables.
const PUSHBACK_WAIT = 0.011167 * 25
var pushback_left = PUSHBACK_WAIT
var is_damaged = false


func _ready():
	self.connect( "lost_all_health", self, "ready_to_die" )
	self.add_to_group( "Enemy" )
	
	$AnimSprite.play()


func _process(delta):
	#Prevent the enemy from glitch
	#jumping super high.
	if velocity.y <= JUMP_STRENGTH :
		velocity.y = JUMP_STRENGTH
	
	if is_alive :
		if can_handle_physics :
			handle_physics( delta )
	call( "process_" + fsm_dict[ fsm_state ], delta )


func been_hit( push : Vector2, damaged = false):
	#Eventually play the correct animation.
	fsm_state = "Pushed"
	velocity = push
	can_handle_physics = false
	is_damaged = damaged


func chase_snowman( snowman ):
	#Ignore everything if dead.
	if is_alive == false:
		return
	
	if snowman == null :
		chase_object = null
		fsm_state = "Wander"
		emit_signal( "change_anim", "walk" )
		return
	
	#Eventually check if player is behind me.
	#Right now just set chase_object to snowman.
	chase_object = snowman
	fsm_state = "Chase"


func jump():
	#Jump up to reach the sky.
	velocity.y = JUMP_STRENGTH


func process_chase( delta ):
	#If the snowman is dead, do not
	#chase it.
	if chase_object.get_parent().is_dead :
		fsm_state = "Wander"
	
	#Chase after the Snowman.
	var chase_after = chase_speed
	chase_after *= clamp( chase_object.global_position.x - self.global_position.x, -1, 1 )
	velocity.x = chase_after
	
	if( on_floor ):
		if( $FloorLeft.is_colliding() == false ||
				$FloorRight.is_colliding() == false ||
				is_on_wall() ):
			jump()

	move_body()


func process_die( delta ): 
	emit_signal( "change_anim", "Die" )
	death_wait -= delta
	
	if death_wait <= 0 :
		self.queue_free()


func process_pushed( delta ):
	#Spaghetti code for the win.
	if is_damaged:
		emit_signal( "change_anim", "Hit" )
	else:
		emit_signal( "change_anim", "Idle" )
	
	pushback_left -= delta
	
	move_body()
	
	if pushback_left <= 0 :
		can_handle_physics = true
		is_damaged = false
		pushback_left = PUSHBACK_WAIT
		
		#Why.
		emit_signal( "change_anim", "Running" )
		if chase_object != null :
			fsm_state = "Chase"
		else:
			fsm_state = "Wander"
	
	


func process_wander( delta ):
	#Don't wander if set to still.
	if is_still :
		emit_signal( "change_anim", "idle" )
		return
	
	#Flip to the other direction if a drop off 
	#is imminent.
	$Falloff.update()
	if ignore_falloff :
		if $Falloff.is_colliding() :
			ignore_falloff = false
	
	elif( $Falloff.is_colliding() == false &&
	on_floor ||
	is_on_wall() ):
		if direction == "Left":
			direction = "Right"
			move_direction = 1
			$Falloff.position.x = -falloff_distance
		else:
			direction = "Left"
			move_direction = -1
			$Falloff.position.x = falloff_distance
		
		#Wait until I get past this falloff
		#before turning around.
		ignore_falloff = true
	
	if on_floor == true :
		velocity.x = walk_speed * move_direction
		
	#Don't move if in air.
	else :
		velocity.x = 0
	
	move_body()


func ready_to_die():
	#Get ready to die.
	#First remove all hitbox collisions.
	for child in get_children() :
		if child.has_method( "is_activated" ) :
			child.is_activated( false )
	
	#Play the sprite and wait for a while before free'ing.
	is_alive = false
	chase_object = null
	self.emit_signal( "change_anim", "Die" )
	fsm_state = "Die"
	
	#Let everything else be in front of me.
	self.z_index = -1



