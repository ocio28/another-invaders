extends Node2D

export(PackedScene) var object

var timer = 0
var spawnTime = 0

func _ready():
	spawn_time()

func _process(delta):
	timer += delta
	if timer > spawnTime:
		spawn()

func spawn():
	var instance = object.instance()
	if randf() > 0.5:
		instance.position = $Left.position
		instance.dir = 1
	else:
		instance.position = $Right.position
		instance.dir = -1
		
	get_parent().add_child(instance)
	spawn_time()
	
func spawn_time():
	timer = 0
	spawnTime = randi() % 8 + 4