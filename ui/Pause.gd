extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("ui_start"):
		get_tree().paused = !get_tree().paused
		self.visible = get_tree().paused
