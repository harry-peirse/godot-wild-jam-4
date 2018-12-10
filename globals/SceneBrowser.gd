extends Node


var scene_list = {
	"Test" : "res://scenes/prototype/Test.tscn",
	"Intro" : "res://scenes/levels/Intro.tscn",
	"Start" : "res://scenes/levels/Start.tscn",
	"OutsideDungeon1" : "res://scenes/levels/OutsideDungeon1.tscn",
	"OutsideDungeon2" : "res://scenes/levels/OutsideDungeon2.tscn",
	"OutsideDungeon3" : "res://scenes/levels/OutsideDungeon3.tscn",
	"ChimneyDescent1" : "res://scenes/levels/ChimneyDescent1.tscn",
	"ChimneyDescent2" : "res://scenes/levels/ChimneyDescent2.tscn",
	"ChimneyDescent3" : "res://scenes/levels/ChimneyDescent3.tscn",
	"LivingRoom" : "res://scenes/levels/LivingRoom.tscn",
	"Temperature Test" : "res://scenes/levels/TemperatureTest.tscn"
}


func load_scene( scene_name ):
	var scene =load( scene_list[ scene_name ] )
	scene = scene
	get_tree().change_scene_to( scene )

func _ready():
	Music.at_title()