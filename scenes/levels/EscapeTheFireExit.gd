extends Node

const STEP_INTERVAL = 0.1
const TRANSITION_INTERVAL = 1
const STEP_DISTANCE = 600

# Called when the node enters the scene tree for the first time.
func _ready():
	$TransitionInterval.set_wait_time(TRANSITION_INTERVAL)
	$TransitionInterval.set_one_shot(true)
	$TransitionInterval.start()

func _walk_to_end_of_level():
	$WalkInterval.set_wait_time(STEP_INTERVAL)
	$WalkInterval.start()

func _walk():
	$Snowman.move_body(Vector2(STEP_DISTANCE, 0))
	if $Snowman.position.x > 800:
		$WalkInterval.stop()
		$WalkInterval.queue_free()
		get_node("/root/SceneBrowser").load_scene("LivingRoom")