extends "res://actors/physics/Physics.gd"


#HHHHEEEEERRRRREEESSS CARL!!!


#Shot scene
var shot = preload( "res://actors/enemy/burglar/Shot.tscn" )

var is_fighting = false


var fsm_dict = {
	"Idle" : "idle",
	"Shot" : "shot",
	"Die" : "die"
}
var fsm_state = "Idle"

#Snowman
var snowman

var face_left = false

#Randomly decide to jump every once in a while.
const JUMP_COOL_WAIT = 0.016667 * 40
var jump_random = 40
var jump_cooldown = 0


#Shot variables.
const FIRE_FROM_IDLE_WAIT = 120
var fire_round = 0
var fire_from_idle = FIRE_FROM_IDLE_WAIT


#Don't do anything if I am dead.
var is_alive = true


func _ready():
	randomize()
	
	$AnimSprite.connect( "animation_finished", self, "change_to_idle" )
	self.connect( "lost_all_health", self, "die" )
	
	$AnimSprite.animation = "Idle"
	$AnimSprite.play()
	
	#De activate attack hitboxes.
	$Shot.is_activated( false )
	
	endurance = 0.4



func _on_Area2D_area_entered(area):
	pass # Replace with function body.


func _on_Area2D_area_exited(area):
	pass # Replace with function body.
	
var counter = 0
func _process(delta):
	if (Input.is_action_just_pressed("ConfirmButton")):
		if  counter==0:
			$Dialogue/Label1.visible = false
			$Dialogue/Label2.visible = true
			counter = 1
		elif counter==1:
			$Dialogue/Label2.visible = false
			$Dialogue/Label3.visible = true
			counter = 2
		elif counter==2:
			$Dialogue/Label3.visible = false
			$Dialogue.visible = false
			$Dialogue/Button.visible = false
			begin_fighting()

		
	



func been_hit( push : Vector2, damaged = false ):
	change_state( "Shot" )


func begin_fighting( boolean = true ):
	is_fighting = true


func change_state( new_state ):
	$AnimSprite.animation = new_state
	fsm_state = new_state


func change_to_idle():
	if $AnimSprite.animation == "Idle" :
		return
		
	if $AnimSprite.animation == "Die" :
		get_tree().quit()
		return
	
	$AnimSprite.animation = "Idle"
	fsm_state = "Idle"
	
	#Reset things.
	fire_round = 0
	
	#Turn off hitboxes.
	$Shot.is_activated( false )


func chase_snowman( new_snowman ):
	snowman = new_snowman
	$Sight.queue_free()


func die():
	is_alive = false
	change_state( "Die" )
	velocity.y = 200


func fire_shot():
	#Where to place the shots.
	var place_add = 40
	var place_start = -20
	
	var count = 0
	while count <= 2 :
		count += 1
		var instance = shot.instance()
		instance.global_position = self.global_position
		instance.global_position.y += place_start
		place_start += place_add
		
		if face_left == false :
			instance.set_direction( 1 )
		
		get_parent().call_deferred( "add_child", instance )


func process_die( delta ):
	move_body()


func process_frame( delta ) :
	if is_fighting == false:
		handle_physics( delta )
		move_body()
		return
	
	#Rotate to face the Snowman.
	if is_alive :
		handle_physics( delta )
		
		jump_cooldown -= delta
		
		if( jump_cooldown <= 0 &&
		randi() % jump_random == 0 &&
		on_floor ):
			velocity.y = -700
			jump_cooldown = JUMP_COOL_WAIT
		
		
		if snowman != null :
			var face = snowman.global_position.x - self.global_position.x
			if face <= 0 :
				face_left = true
			else:
				face_left = false
		$AnimSprite.flip_h = face_left
	
	#Fall downward if dead and in air.
	
	call( "process_" + fsm_dict[ fsm_state ], delta )


func process_idle( delta ) :
	#If I have reached fire_from_idle 
	#countdown.
	if fire_from_idle == 0 :
		fire_from_idle = FIRE_FROM_IDLE_WAIT
		change_state("Shot")
		return
	fire_from_idle -= 1
	
	move_body()


func process_shot( delta ):
	move_body()
	
	#Turn on my hitbox.
	$Shot.is_activated( true )
	
	fire_round += 1
	
	if fire_round == 2 :
		fire_shot()
	elif fire_round == 20:
		fire_shot()
	elif fire_round == 80:
		fire_shot()
	elif fire_round == 98:
		fire_shot()


func pushback( push : Vector2, damaged = false ):
	been_hit( push, damaged )



