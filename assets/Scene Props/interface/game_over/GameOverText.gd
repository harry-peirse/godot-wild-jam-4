extends RichTextLabel

var speed = 30

var destination = self.rect_position.y + 60


func _process( delta ):
	rect_position.y += speed * delta
	
	if rect_position.y >= destination :
		rect_position.y = destination
		set_process( false )


func _ready():
	set_process( false )


func begin_playing():
	set_process( true )