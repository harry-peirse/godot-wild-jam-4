extends Node


var scene_list = {
	"Test" : "res://scenes/prototype/Test.tscn",
	"ChimneyDescent1" : "res://scenes/levels/ChimneyDescent1.tscn",
	"ChimneyDescent2" : "res://scenes/levels/ChimneyDescent2.tscn",
	"LivingRoom" : "res://scenes/levels/LivingRoom.tscn"
}


func load_scene( scene_name ):
	var scene =load( scene_list[ scene_name ] )
	scene = scene
	get_tree().change_scene_to( scene )
