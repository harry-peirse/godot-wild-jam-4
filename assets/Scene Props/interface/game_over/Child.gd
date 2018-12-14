extends Sprite


#Move to the right a little while,
#than start crying.

var has_not_reached_destination : bool = true
export var destination = 200

var walk_speed = 50

#This lets whatever is listening know
#that I have reached my destination.
signal reached_destination


func _process(delta):
	if has_not_reached_destination :
		self.position.x += walk_speed * delta
	
	
	if position.x >= destination :
		has_not_reached_destination = false
		self.emit_signal( "reached_destination" )
		#Start crying.