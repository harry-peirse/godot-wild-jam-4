extends Area2D

const TIME_RESET = 0.016667 * 25 
var damage = 10
var time = TIME_RESET

var snowman = null

func _ready():
	self.connect( "area_entered", self, "entered" )
	self.connect( "area_exited", self, "exited" )
	
	set_physics_process( false )
	


func _physics_process(delta):
	time -= delta
	
	if time <= 0 :
		time = TIME_RESET
	
		snowman.get_parent().lost_health( damage )


func entered( actor ):
	snowman = actor
	set_physics_process( true )


func exited( actor ):
	snowman = null
	set_physics_process( false)