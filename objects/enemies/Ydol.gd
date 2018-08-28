extends Node2D

export (bool) var lock = false

var closed = true
var creatures = null

func _ready():
	State.enemies += 1
	creatures = get_parent().get_node("Creatures")

func _process(delta):
	if creatures.get_child_count() == 0:
		closed = false

func move(pos):
	if not lock:
		translate(pos)

func take_damage(damage):
	if closed:
		return 10
	else:
		State.kill_ydol()
		queue_free()
