extends Area2D


#Instance this scene inside an enemy
#to give said enemy the ability
#to chase the player.


#Determine if I am allowed to look behind myself.
var direction = 1


func _process(delta):
	direction = get_parent().direction
	
	
func _ready():
	self.connect( "area_entered", self, "snowman_spotted" )
	self.connect( "area_exited", self, "snowman_left" )


func snowman_left( snowman ):
	get_parent().chase_snowman( null )


func snowman_spotted( snowman ):
	#I spy a snowman.
	get_parent().chase_snowman( snowman )
	
	#Test that this is working.
	
	pass
	