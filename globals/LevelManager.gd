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


func house_started( house_name ):
	attempt = house_name


func house_ready( house_name ):
	if completed_houses.has( house_name ) :
		return true
	
	if waiting_houses.has( house_name ) :
		return false
	
	waiting_houses.append( house_name )
	return false
	
	
	