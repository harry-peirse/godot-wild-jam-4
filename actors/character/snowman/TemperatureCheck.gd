extends Area2D

const GROWTH_RATE = 0.2
var snowmanScale = 1.0
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
		snowmanScale += GROWTH_RATE * delta
	elif heat:
		snowmanScale -= GROWTH_RATE * delta
	get_parent().change_scale(snowmanScale)