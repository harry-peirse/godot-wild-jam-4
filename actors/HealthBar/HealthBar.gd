tool
extends TextureProgress


var change = 0.016667 * 225


var health_object


func _process(delta):
	change -= delta
	
	if change >= 0 :
		return
	
	if $Lights1.visible == true :
		$Lights1.visible = false
		$Lights2.visible = true

	else:
		$Lights2.visible = false
		$Lights1.visible = true

	change = 0.011167 * 225
	

func update_value( new_value ):
	self.value = new_value


func set_health_object( new_object ):
	health_object = new_object
	health_object.connect( "health_changed", self, "update_value" )
