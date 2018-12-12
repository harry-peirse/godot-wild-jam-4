extends CanvasLayer

var next_scene

func fade_in():	
	$AnimationPlayer.play("FadeIn")
	

func fade_out(scene):
	next_scene = scene
	$AnimationPlayer.play("FadeOut")
	

func change_scene():
	var scene = load( next_scene )
	get_tree().change_scene_to( scene )
	fade_in()