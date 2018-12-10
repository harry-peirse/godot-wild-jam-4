extends AudioStreamPlayer


#Play music lol.
var current_song #Is song name.
var last_song : AudioStream

func at_title():
	if not_playing( "title" ) :
		last_song = self.stream
		self.stream = load( "res://assets/music/snowman-title-music.ogg" )
		current_song = "title"
		self.play()


func at_outside():
	if not_playing( "outside" ) :
		last_song = self.stream
		self.stream = load( "res://assets/music/snowman-outside-music.ogg" )
		current_song = "outside"
		self.play()

func silence():
	last_song = self.stream
	self.stop()

func not_playing( check_song ):
	if current_song == null  :
		return true
	
	var is_same_song = current_song != check_song
	return is_same_song


func _ready():
	#Play the title song.
	at_title()
	

func revert():
	#Go to the previous song.
	if last_song != null :
		self.stream = last_song
		self.play()