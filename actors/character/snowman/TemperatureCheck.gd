extends Area2D

const GROWTH_RATE = 1.01
var cold = false
var heat = false

func startFeelingCold():
	cold = true
	
func stopFeelingCold():
	cold = false
	
func startFeelingHeat():
	heat = true
	
func stopFeelingHeat():
	heat = false
	
func _physics_process(delta):
	if cold:
		get_parent().size *= 1 + (GROWTH_RATE * delta)
	elif heat:
		get_parent().size *= 1 - (GROWTH_RATE * delta)