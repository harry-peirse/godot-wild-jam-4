extends Node


var scene_list = {
	"Test" : "res://scenes/prototype/Test.tscn"
}


func load_scene( scene_name ):
	var scene =load( scene_list[ scene_name ] )
	scene = scene
	get_tree().change_scene_to( scene )
