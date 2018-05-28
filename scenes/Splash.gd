extends Node2D

func _ready():
	State.load_game()

func _on_Timer_timeout():
	State.goto_scene("Title")
