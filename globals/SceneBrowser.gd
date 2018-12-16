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
	"ChimneyDescent4" : "res://scenes/levels/ChimneyDescent4.tscn",
	"FreeFallDungeon" : "res://scenes/levels/ChimneyDescent5.tscn",
	"LivingRoom" : "res://scenes/levels/LivingRoom.tscn",
	"Temperature Test" : "res://scenes/levels/TemperatureTest.tscn",
	"EscapeTheFire1": "res://scenes/levels/EscapeTheFire/EscapeTheFire1.tscn",
	"EscapeTheFire2": "res://scenes/levels/EscapeTheFire/EscapeTheFire2.tscn",
	"EscapeTheFire3": "res://scenes/levels/EscapeTheFire/EscapeTheFire3.tscn",
	"EscapeTheFire4": "res://scenes/levels/EscapeTheFire/EscapeTheFire4.tscn",
	"EscapeTheFire5": "res://scenes/levels/EscapeTheFire/EscapeTheFire5.tscn",
	"EscapeTheFire6": "res://scenes/levels/EscapeTheFire/EscapeTheFire6.tscn",
	"EscapeTheFire7": "res://scenes/levels/EscapeTheFire/EscapeTheFire7.tscn",
	"EscapeTheFire8": "res://scenes/levels/EscapeTheFire/EscapeTheFire8.tscn",
	"EscapeTheFire9": "res://scenes/levels/EscapeTheFire/EscapeTheFire9.tscn",
	"EscapeTheFire10": "res://scenes/levels/EscapeTheFire/EscapeTheFire10.tscn",
	"EscapeTheFire11": "res://scenes/levels/EscapeTheFire/EscapeTheFire11.tscn",
	"EscapeTheFire12": "res://scenes/levels/EscapeTheFire/EscapeTheFire12.tscn",
	"EscapeTheFireExit": "res://scenes/levels/EscapeTheFire/EscapeTheFireExit.tscn",
	"GameOver": "res://scenes/gameover_screen/GameOver.tscn",
	"CarlsEnding": "res://scenes/levels/Carl/CarlsEnding.tscn",
	"LivingRoom2": "res://scenes/levels/DifferentLivingRooms/LivingRoom2.tscn",
	"LivingRoom3": "res://scenes/levels/DifferentLivingRooms/LivingRoom3.tscn",
	"LivingRoom4": "res://scenes/levels/DifferentLivingRooms/LivingRoom4.tscn",
	"KrampusFight": "res://scenes/krampus/KrampusFight.tscn",
	"JoinEnd": "res://scenes/levels/Decision2.tscn",
	"DeadEnd": "res://scenes/levels/Decision1.tscn",
	
}


func load_scene( scene_name ):
 	Transition.fade_out(scene_list[ scene_name ])
