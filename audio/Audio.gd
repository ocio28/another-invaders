extends Node2D

var index = 0

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
		
func move():
	match index:
		0: move_right()
		1: move_left()
		2: move_down()
	index += 1
	if index > 2:
		index = 0
		
func move_right():
	if State.config.sound:
		$Move1.play()
		
func move_left():
	if State.config.sound:
		$Move2.play()
		
func move_down():
	if State.config.sound:
		$Move3.play()
		
func isPlaying():
	return $Move1.playing || $Move2.playing || $Move3.playing