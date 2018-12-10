extends Area2D

const GROWTH_RATE = 1.01
var cold = false
var heat = false

func startFeelingCold():
	cold = true
	print("feeling cold")
	
func stopFeelingCold():
	cold = false
	print("not feeling cold")
	
func startFeelingHeat():
	heat = true
	print("feeling heat")
	
func stopFeelingHeat():
	heat = false
	print("not feeling heat")
	
func _physics_process(delta):
	if cold:
		get_parent().size *= 1 + (GROWTH_RATE * delta)
	elif heat:
		get_parent().size *= 1 - (GROWTH_RATE * delta)