extends AudioStreamPlayer


#Play music lol.
var current_song #Is song name.
var last_song : AudioStream

var tracks = {}

func _ready():
	tracks = {
		title = load( "res://assets/music/title.ogg" ),
		intro = load( "res://assets/music/intro.ogg" ),
		outside = load ( "res://assets/music/outside.ogg" ),
		panic = load ( "res://assets/music/panic.ogg" )
	}
	
	play_track(tracks.title)

func play_track(stream):
	if not_playing(stream) :
		self.stream = stream
		current_song = stream
		self.play()


func silence():
	current_song = null	
	self.stop()

func not_playing( check_song ):
	return current_song != check_song