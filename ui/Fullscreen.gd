extends Node2D

func _on_Area2D_area_entered(area):
	area.get_parent().visible = false
	OS.window_fullscreen = !OS.window_fullscreen
	if !OS.window_fullscreen:
		OS.window_size = Vector2(State.config.viewport.x ,State.config.viewport.y)
		OS.request_attention()
	
	if OS.window_fullscreen:
		$Active.text = "on"
	else:
		$Active.text = "off"
	$Active.play_blink()
	$OffTimer.start()

func _on_OffTimer_timeout():
	$Active.stop_blink()