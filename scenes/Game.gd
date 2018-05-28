extends Node2D

func _ready():
	var stage = load("res://stages/Stage" + str(State.stage) + ".tscn")
	var instance = stage.instance()
	add_child(instance)
	get_tree().paused = true
	State.stage_time = 0

func _process(delta):
	State.stage_time += delta
	if State.lifes < 0:
		State.game_over()
