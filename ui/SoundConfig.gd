extends Node2D

func _on_Area2D_area_entered(area):
	State.config.sound = !State.config.sound
	area.get_parent().visible = false
	if State.config.sound:
		$Sound.text = "on"
	else:
		$Sound.text = "off"
	$Sound.play_blink()
	$OffTimer.start()

func _on_OffTimer_timeout():
	$Sound.stop_blink()
