#extends "res://screens/basic_screen.gd"
extends Node

onready var containerPlayer = $MarginContainer/HBoxContainer

func _ready():
	$MarginContainer/HBoxContainer/Label.text = "GAME OVER"
	pass
	