extends Node

var sounds = {
	"shoot": load("res://assets/sound/shoot.wav")
}

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func shoot():
	if State.config.sound:
		sounds.shoot.play()
