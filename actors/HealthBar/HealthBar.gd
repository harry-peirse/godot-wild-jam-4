extends TextureProgress


var health_object


func update_value( new_value ):
	self.value = new_value


func set_health_object( new_object ):
	health_object = new_object
	health_object.connect( "health_changed", self, "update_value" )
