extends AudioStreamPlayer

onready var tracks = {
	title = load( "res://assets/music/title.ogg" ),
	intro = load( "res://assets/music/intro.ogg" ),
	outside = load ( "res://assets/music/outside.ogg" ),
	panic = load ( "res://assets/music/panic.ogg" )
}

var tracks = {}

func _ready():
	tracks = {
		title = load( "res://assets/music/title.ogg" ),
		intro = load( "res://assets/music/intro.ogg" ),
		outside = load ( "res://assets/music/outside.ogg" ),
		panic = load ( "res://assets/music/panic.ogg" )
	}


	play_track(tracks.title)


func play_track(stream, delay = 0.5):
	if self.stream != stream :
		self.stream = stream	
		if delay > 0:
			silence()
			$Timer.wait_time = delay
			$Timer.start()
			yield($Timer, "timeout")

		self.play()


func silence():

	current_song = null
	self.stop()

func not_playing( check_song ):


