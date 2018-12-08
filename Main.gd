extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$ItemList.connect( "item_activated", self, "load_scene" )
	
	for scene_name in SceneBrowser.scene_list.keys():
		$ItemList.add_item(scene_name)
	
func load_scene(index):
	var scene_to_play = $ItemList.get_item_text(index)
	SceneBrowser.load_scene( scene_to_play )