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

#Determines how resistant an entity is to damage.
#Multiplier value. Lower means less damage from
#attacks.
var endurance = 1

func _ready():
	self.connect( "damage", self, "damage" )
	self.connect( "gain_health", self, "gain_health" )
	self.connect( "lose_health", self, "lose_health" )
	self.connect( "lost_all_health", self, "health_gone"  )
	
	for child in get_children():
		if child.has_method( "set_health_object" ):
			child.set_health_object( self )
			child.update_value( health )


func damage( amount : float ):
	health -= amount * endurance
	
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