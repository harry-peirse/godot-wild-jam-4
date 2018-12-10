extends "res://actors/Health.gd"


#How fast the enemy walks around when not
#in pursut.
export var walk_speed = 200

#When true, the enemy does not wander.
export var is_still = false

signal pushback

var fsm_state = {
	"Wander" : "wander",
}


func _ready():
	self.connect( "lost_all_health", self, "queue_free" )