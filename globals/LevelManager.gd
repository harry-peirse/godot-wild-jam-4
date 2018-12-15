extends Node


#This keeps track of what levels 
#need to still be completed.

#Which house we are attempting to complete.
var attempt 


var completed_houses = []
var waiting_houses = []


func house_beaten():
	if attempt == null :
		return
	
	var house_at
	house_at = waiting_houses.find( attempt )
	waiting_houses.remove( house_at )
	completed_houses.append( attempt )
	attempt = null


func house_started( house ):
	attempt = house.name


func house_ready( house ):
	#Check if we have enough houses done
	#for CarlsEnd and Krampus.
	if house.name == "Krampus" && completed_houses.size() < 7 :
		house.queue_free()
	
	if house.name == "CarlsEnd" && completed_houses.size() < 11 :
		house.queue_free()
	
	if completed_houses.has( house.name ) :
		house.queue_free()
	
	if waiting_houses.has( house.name ) :
		return
	
	#The house is a new one, yay.
	waiting_houses.append( house.name )
	return
	
	
	