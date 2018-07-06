extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func ufo_engine():
	$Ufo.play()
	
func ufo_engine_stop():
	$Ufo.stop()
	
func explosion():
	if State.config.sound:
		$Explosion.play()

func shoot():
	if State.config.sound:
		$Shoot.play(0)

func item():
	if State.config.sound:
		$Item.play(0)


func _on_Ufo_finished():
	$Ufo.play()
