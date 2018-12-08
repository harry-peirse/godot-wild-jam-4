extends Node2D

#Base script for all entities that use health.
#Needs testing.

signal damage
signal gain_health
signal lose_health
signal lost_all_health

#Amount of health from a hundred to zero.
var health = 100

#Determines how resistant an entity is to damage.
#Multiplier value. Lower means less damage from
#attacks.
var endurance = 1


func _ready():
	self.connect( "damage", self, "damage" )
	self.connect( "gain_health", self, "gain_health" )
	self.connect( "lose_health", self, "lose_health" )


func damage( amount : float ):
	health -= amount * endurance
	
	if health <= 0 :
		emit_signal( "lost_all_health" )


func gain_health( amount : float, can_exceed_100 : bool = false ) :
	if can_exceed_100 :
		health += amount
	else:
		health = min( health + amount, 100 ) 
	
	
func lost_health( amount : float ):
	health -= amount
	
	if health <= 0 :
		emit_signal( "lost_all_health" ) 