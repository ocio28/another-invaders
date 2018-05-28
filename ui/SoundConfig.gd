extends Node2D

func _on_Area2D_area_entered(area):
	State.config.sound = !State.config.sound
	$Wave.visible = State.config.sound
	area.get_parent().visible = false
