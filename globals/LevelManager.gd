extends Node


#This keeps track of what levels 
#need to still be completed.

#Which house we are attempting to complete.
var attempt 


var completed_houses = []
var waiting_houses = []

var snowman_location

#Checkmark
var checkmark = preload( "res://scenes/Visited mark.tscn" )
var lock_mark = preload( "res://scenes/LockedMark.tscn" )


func get_snowman_location():
	return snowman_location


func house_beaten():
	if attempt == null :
		return
	
	var house_at
	house_at = waiting_houses.find( attempt )
	waiting_houses.remove( house_at )
	completed_houses.append( attempt )
	attempt = null


func house_started( house ):
	snowman_location = house.global_position
	var house_name = house.name
	attempt = house.name


func house_ready( house ):
	#Check if we have enough houses done
	#for CarlsEnd and Krampus.
	if( waiting_houses.has( "Krampus" ) && 
	house.name == "Krampus" && 
	completed_houses.size() < 7 ):
		house.queue_free()
		place_checkmark( house, true )
		return
	
	if( waiting_houses.has( "CarlsEnding" ) &&
	house.name == "CarlsEnding" && 
	completed_houses.size() < 10 ):
		house.queue_free()
		place_checkmark( house, true )
		return
	
	#If house is already beaten,
	#do not go back into it.
	if completed_houses.has( house.name ) :
		house.queue_free()
		place_checkmark( house )
		return
	
	#House is in the list already,
	#do not add it again.
	if waiting_houses.has( house.name ) :
		return
	
	#The house is a new one, yay.
	waiting_houses.append( house.name )
	return
	
	
func place_checkmark( house, boolean = false ):
	#Place the checkmark at house's position.
	var instance = checkmark.instance()
	if boolean :
		instance = lock_mark.instance()
	
	var root = get_tree().get_root().get_node( "OutsideDungeon1" )
	instance.global_position = house.global_position
	root.call_deferred( "add_child", instance )
	
	
func reset_snowman_location():
	snowman_location = null	
	
	
	
	