extends "res://actors/physics/Physics.gd"


#HHHHEEEEERRRRREEESSS CARL!!!


var fsm_dict = {
	"Idle" : "idle"
}
var fsm_state = "Idle"

#Snowman
var snowman

var face_left = false


#Don't do anything if I am dead.
var is_alive = true


func _ready():
	$AnimSprite.connect( "animation_finished", self, "change_to_idle" )
	
	$AnimSprite.animation = "Idle"
	$AnimSprite.play()
	
	endurance = 0.3


func been_hit( push : Vector2, damaged = false ):
	pass


func change_to_idle():
	if $AnimSprite.animation == "Idle" :
		return
	
	$AnimSprite.animation = "Idle"
	fsm_state = "Idle"


func chase_snowman( new_snowman ):
	snowman = new_snowman
	$Sight.queue_free()


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
	#Sway back and forth.
	handle_physics( delta )
	
	move_body()


func pushback( push : Vector2, damaged = false ):
	been_hit( push, damaged )

