extends Node2D

func _on_Area2D_area_entered(area):
	OS.window_fullscreen = !OS.window_fullscreen
	if !OS.window_fullscreen:
		OS.window_size = Vector2(State.config.viewport.x ,State.config.viewport.y)
		OS.request_attention()
	
	if OS.window_fullscreen:
		$Label.text = "window"
	else:
		$Label.text = "fullscreen"
	$Label.play_blink()
	$OffTimer.start()

func _on_OffTimer_timeout():
	$Label.stop_blink()