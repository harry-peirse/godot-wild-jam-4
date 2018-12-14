tool
extends Node2D


const HEALTH_75 = Color( 1,1,1,1 )
const HEALTH_25 = Color( 0,0.95,0.06,1 )
const HEALTH_0 = Color( 1,0,0,1 )


var change = 0.016667 * 150


var health_object


func _process(delta):
	#Change the color of the lights.
	change -= delta
	
	if change >= 0 :
		return
	
	if $Lights1.visible == true :
		$Lights1.visible = false
		$Lights2.visible = true

	else:
		$Lights2.visible = false
		$Lights1.visible = true

	change = 0.011167 * 175
	
	
func _ready():
	$Timer.connect( "timeout", self, "hide" )	
	

func update_value( new_value ):
	$Health.value = new_value
	
	#Show myself for a brief time.
	self.show()
	
	if new_value > 75 :
		$Health.modulate = HEALTH_75
	elif new_value > 25 :
		$Health.modulate = HEALTH_25
	elif new_value > 0 :
		$Health.modulate = HEALTH_0
		$Timer.stop()
		return
	
	$Timer.start()


func set_health_object( new_object ):
	health_object = new_object
	health_object.connect( "health_changed", self, "update_value" )


func is_health_bar():
	pass