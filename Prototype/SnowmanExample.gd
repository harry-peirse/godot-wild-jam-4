extends Area2D

#Signals are great for calling methods in
#physics objects. Godot does not crash if it
#attempts to emit a signal inside a body
#that does not exist.
signal inside_shrink
signal outside_shrink


#How the snowman knows that it should start
#shrinking.
var is_shrinking = false

#Determines how large the snowman is.
var size = 1
onready var original_col_extents = $Col.shape.extents
onready var original_sprite_scale = $Sprite.scale


func _process(delta):
	var move = 0
	move += (int( Input.is_action_pressed("ui_right") ) - 
	int( Input.is_action_pressed( "ui_left" ) ) )
	
	position.x += (move * 80) * delta
	
	
	if is_shrinking :
		size = max(size - 0.100, 0.500 )
		change_scale( size )
	
	else:
		size = min( size + 0.050, 1 )
		change_scale( size )


func _ready():
	self.connect( "inside_shrink", self, "inside_shrink" )
	self.connect( "outside_shrink", self, "outside_shrink" )


func change_scale( new_scale : float ):
	$Col.shape.extents = original_col_extents * new_scale
	$Sprite.scale = original_sprite_scale * new_scale


func inside_shrink( area ):
	#Let the Snowman know it should begin shrinking.
	is_shrinking = true


func outside_shrink( area ):
	is_shrinking = false