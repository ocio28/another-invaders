extends Node2D

func _on_Area2D_area_entered(area):
	$Play.play_blink()
	$OffTimer.start()
	area.get_parent().queue_free()

func _on_OffTimer_timeout():
	State.start_new_game()
