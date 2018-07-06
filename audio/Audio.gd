extends Node2D

func ufo_engine():
	if State.config.sound:
		$Ufo.play()
	
func explosion():
	if State.config.sound:
		$Explosion.play()

func shoot():
	if State.config.sound:
		$Shoot.play()

func item():
	if State.config.sound:
		$Item.play()

func destroy():
	if State.config.sound:
		$Destroy.play()