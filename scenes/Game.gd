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

	for b in instance.get_node("Enemies").get_children():
		b.connect("enemy_move_signal", self, "play_move")

func _process(delta):
	playing_move = false
	State.stage_time += delta
	if State.lifes < 0:
		State.game_over()
		
func play_move():
	if State.config.sound:
		if not playing_move:
			match index:
				0: $Move1.play()
				1: $Move2.play()
				2: $Move3.play()
			index += 1
			if index > 2:
				index = 0
		playing_move = true