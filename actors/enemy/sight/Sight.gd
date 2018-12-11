extends Area2D


#Instance this scene inside an enemy
#to give said enemy the ability
#to chase the player.


#Determine if I am allowed to look behind myself.
var direction = 1

#This tells me to check if the snowman
#is outside my range of sight after
#starting a chase.
var losing_snowman = false
var chase_object = null
const MAX_SNOWMAN_DISTANCE = 500


func _process(delta):
	direction = get_parent().direction
	
	#Check if the Snowman has been lost.
	if losing_snowman :
		var distance = chase_object.global_position - self.global_position
		if distance.length() >= MAX_SNOWMAN_DISTANCE :
			chase_object = null
			losing_snowman = false
			get_parent().chase_snowman( null )
			
	
	
func _ready():
	self.connect( "area_entered", self, "snowman_spotted" )
	self.connect( "area_exited", self, "snowman_left" )


func snowman_left( snowman ):
	losing_snowman = true


func snowman_spotted( snowman ):
	#I spy a snowman.
	chase_object = snowman
	get_parent().chase_snowman( snowman )
	
	#Test that this is working.
	
	pass
	