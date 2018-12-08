extends Node


var scene_list = {
	"Test" : "res://Prototype/Test.tscn"
}


func load_scene( scene_name ):
	var scene =load( scene_list[ scene_name ] )
	scene = scene
	get_tree().change_scene_to( scene )