extends KinematicBody2D

#Base script for all entities that use health.
#Needs testing.

signal damage
signal gain_health
signal lose_health
signal lost_all_health
signal health_changed

#Amount of health from a hundred to zero.
var health = 100

#Free myself after this amount of time has passed.
var dead_wait = 0.016667 * 60

var been_damaged = false

#Determines how resistant an entity is to damage.
#Multiplier value. Lower means less damage from
#attacks.
export var endurance = 1

func _ready():
	self.connect( "damage", self, "damage" )
	self.connect( "gain_health", self, "gain_health" )
	self.connect( "lose_health", self, "lose_health" )
	
	
	for child in get_children():
		if child.has_method( "set_health_object" ):
			child.set_health_object( self )
			child.update_value( health )
		
		#Check if we have a health bar.
		if child.has_method( "is_health_bar" ) :
			self.connect( "health_changed", child, "update_value" )


func damage( amount : float ):
	health -= amount * endurance
	been_damaged = true
	
	if health <= 0 :
		emit_signal( "lost_all_health" )
	
	return health_changed()


func gain_health( amount : float, can_exceed_100 : bool = false ) :
	if can_exceed_100 :
		health += amount
	else:
		health = min( health + amount, 100 ) 
	
	return health_changed()
	
	
func health_changed():
	emit_signal( "health_changed", health )
	return health


func lost_health( amount : float ):
	health -= amount
	
	if health <= 0 :
		emit_signal( "lost_all_health" ) 
	
	return health_changed()


func set_health( new_health ):
	health = new_health
	health_changed()