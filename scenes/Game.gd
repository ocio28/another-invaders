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
		b.connect("enemy_death_signal", self, "play_destroy")
		b.connect("enemy_move_signal", self, "play_move")

func _process(delta):
	State.stage_time += delta
	if State.lifes < 0:
		State.game_over()

func play_destroy():
	if State.config.sound:
		$DeathEnemyStream.play()
		
func play_move():
	if State.config.sound:
		#if not playing_move:
		#	match index:
		playing_move = true