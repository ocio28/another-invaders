extends Node2D

var playing_move = false
var index = 0

func _ready():
	var stage = load("res://stages/Stage" + str(State.stage) + ".tscn")
	if stage == null:
		State.goto_scene("GameProgress")
		return
	var instance = stage.instance()
	add_child(instance)
	get_tree().paused = true
	State.stage_time = 0

func _process(delta):
	playing_move = false
	State.stage_time += delta
	if State.lifes < 0:
		State.game_over()