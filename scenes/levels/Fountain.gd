extends Area2D



var health_to_give = 20

signal fountain_entered

func _on_Fountain_area_entered(actor):
	#Do not do anything if there is no
	#health to give
	
	emit_signal("fountain_entered")
	$Fountain/FountainDialogue.visible = true
#	t.set_wait_time(4)
#	t.start()
#	yield(t, "timeout")
	$Fountain/FountainDialogue.visible = false
	
	#Heal the Snowman.
	actor.get_parent().gain_health( health_to_give )
	health_to_give = 0
	self.disconnect( "area_entered", self, "_on_Fountain_area_entered" )

func _on_Fountain_area_exited(actor):
	$Fountain/FountainDialogue.visible = false
