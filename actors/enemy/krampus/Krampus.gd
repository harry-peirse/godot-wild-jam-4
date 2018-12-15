extends "res://actors/physics/Physics.gd"


#HHHHEEEEERRRRREEESSS CARL!!!


#Shot scene
var shot = preload( "res://actors/enemy/burglar/Shot.tscn" )

var fsm_dict = {
	"Idle" : "idle",
	"Shot" : "shot"
}
var fsm_state = "Idle"

#Snowman
var snowman

var face_left = false

#Shot variables.
var fire_round = 0


#Don't do anything if I am dead.
var is_alive = true


func _ready():
	$AnimSprite.connect( "animation_finished", self, "change_to_idle" )
	
	$AnimSprite.animation = "Idle"
	$AnimSprite.play()
	
	#De activate attack hitboxes.
	$Shot.is_activated( false )
	
	endurance = 0.3


func been_hit( push : Vector2, damaged = false ):
	change_state( "Shot" )


func change_state( new_state ):
	$AnimSprite.animation = new_state
	fsm_state = new_state


func change_to_idle():
	if $AnimSprite.animation == "Idle" :
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
	


func process_frame( delta ) :
	#Rotate to face the Snowman.
	if is_alive :
		if snowman != null :
			var face = snowman.global_position.x - self.global_position.x
			if face <= 0 :
				face_left = true
			else:
				face_left = false
		$AnimSprite.flip_h = face_left
	
	call( "process_" + fsm_dict[ fsm_state ], delta )


func process_idle( delta ) :
	


	handle_physics( delta )
	
	move_body()


func process_shot( delta ):
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

