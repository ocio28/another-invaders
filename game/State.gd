extends Node2D

var config = {
	"sound": true,
	"viewport": Vector2(OS.window_size.x, OS.window_size.y)
}
var top_scores = []

var current_scene = null
var score = 0
var lifes = 2
var stage = 1
var enemies = 0
var stage_time = 0
var game_time = 0

var demoPlay = true
var running = false

func _ready():
    var root = get_tree().get_root()
    current_scene = root.get_child(root.get_child_count() -1)
	
func _process(delta):
	if running:
		game_time += delta
	if Input.is_action_just_pressed("ui_restart"):
		State.goto_scene("Splash")
	if Input.is_action_just_pressed("ui_exit"):
		get_tree().quit()

func kill_enemy(value):
	add_score(value)
	enemies -= 1
	
func add_score(value):
	score += value
	
func player_take_damage():
	lifes -= 1
	
func start_new_game():
	running = true
	score = 0
	lifes = 2
	stage = 0
	goto_scene("GameProgress")
	
func game_over():
	running = false
	goto_scene("GameOver")
	
func next_stage():
	stage += 1
	enemies = 0
	if stage < 5:
		goto_scene("Game")
	else:
		goto_scene("GameProgress")

func do_action(action):
	print(action)
	match action:
		0: stage = 1
		1: stage = 1
		2: stage = 1
		3: stage = 1
		
	goto_scene("Game")

func save_game(name):
	top_scores.append({
		"name": name,
		"score": score,
		"time": game_time
	})
	var game_data = {
		"sound": config.sound,
		"scores": top_scores
	}
	var game_file = File.new()
	game_file.open("user://game.save", File.WRITE)
	game_file.store_var(game_data)
	game_file.close()

func load_game():
	var game_file = File.new()
	if !game_file.file_exists("user://game.save"):
		return
	game_file.open("user://game.save", File.READ)
	while not game_file.eof_reached():
		var line = game_file.get_var()
		if line !=  null:
			config.sound = line["sound"]
			top_scores = line["scores"]

func goto_scene(name):
	# This function will usually be called from a signal callback,
	# or some other function from the running scene.
	# Deleting the current scene at this point might be
	# a bad idea, because it may be inside of a callback or function of it.
	# The worst case will be a crash or unexpected behavior.

	# The way around this is deferring the load to a later time, when
	# it is ensured that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", "res://scenes/" + name + ".tscn")

func _deferred_goto_scene(path):
	# Immediately free the current scene,
	# there is no risk here.
	current_scene.free()

	print(path)
	# Load new scene
	var s = ResourceLoader.load(path)

	# Instance the new scene
	current_scene = s.instance()

	# Add it to the active scene, as child of root
	get_tree().get_root().add_child(current_scene)
	
func to_time(time):
	var minutes = int(floor((time / 60))) % 60
	var seconds = int(floor(time)) % 60
	var txt = ""
	
	if minutes < 10:
		txt += "0"
	txt += str(minutes) + ":"
	
	if seconds < 10:
		txt += "0"
	txt += str(seconds)
	
	return txt