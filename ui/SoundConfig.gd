extends Node2D

func _ready():
	sound_change()
	
func sound_change():
	if State.config.sound:
		$Sound.text = "sound"
	else:
		$Sound.text = "mute"
	State.save_game()

func _on_Area2D_area_entered(area):
	State.config.sound = !State.config.sound
	sound_change()
	$Sound.play_blink()
	$OffTimer.start()

func _on_OffTimer_timeout():
	$Sound.stop_blink()
