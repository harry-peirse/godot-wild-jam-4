extends KinematicBody2D


var HIT_POS = 500


var direction = -1


var velocity = Vector2( 150, 0 )


func _process(delta):
	self.move_and_slide( velocity )


func _ready():
	if direction == 1 :
		$Sprite.flip_h = true
		HIT_POS = -HIT_POS
	
	velocity.x *= direction
	
	#This keeps Hitbox sending victims in
	#the correct direction.
	$Hitbox.position.x = HIT_POS
	$Hitbox/Col.position.x = -HIT_POS
	
	#Free myself when time is up.
	$Timer.connect( "timeout", self, "queue_free" )


func set_direction( new_direction ):
	direction = new_direction