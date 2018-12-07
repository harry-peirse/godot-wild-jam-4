extends Area2D


func _ready():
	self.connect( "area_entered", self, "shrink" )
	self.connect( "area_exited", self, "stop_shrink" )
	
func _process(delta):
	for body in get_overlapping_areas():
		pass


func shrink( body ):
	body.emit_signal( "inside_shrink" )


func stop_shrinking( body ):
	body.emit_signal( "outside_shrink" )