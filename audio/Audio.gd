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
		
func move_right():
	if State.config.sound && not $Move1.is_playing:
		$Move1.play()
		
func move_left():
	if State.config.sound && not $Move2.is_playing:
		$Move2.play()
		
func move_down():
	if State.config.sound && not $Move3.is_playing:
		$Move3.play()