extends Node2D

func _on_Area2D_area_entered(area):
	OS.window_fullscreen = !OS.window_fullscreen
	if !OS.window_fullscreen:
		OS.window_size = Vector2(State.config.viewport.x ,State.config.viewport.y)
		OS.request_attention()
	area.get_parent().visible = false
