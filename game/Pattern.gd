extends Node2D

enum ACTIONS {LEFT, RIGHT, UP, DOWN}
enum PATTERNS {BASIC, H1}

const BASIC = [RIGHT, RIGHT, RIGHT, DOWN, LEFT, LEFT, LEFT, DOWN]
const H1 = [RIGHT, RIGHT, LEFT, LEFT, DOWN]
const H2 = [LEFT, RIGHT, RIGHT, LEFT, DOWN]

export(PATTERNS) var pattern
var current = BASIC

var index = 0
var time = 0

func _ready():
	match pattern:
		PATTERNS.BASIC: current = BASIC
		PATTERNS.H1: current = H1

func _process(delta):
	time += delta
	if time > 0.8:
		timeout()
		
func timeout():
	time = 0
	var action = current[index]
	index += 1
	if index == current.size():
		index = 0
	move(action)

func move(action):
	match action:
		ACTIONS.RIGHT: 
			translate(Vector2(16, 0))
			Audio.move_right()
		ACTIONS.LEFT:
			translate(Vector2(-16, 0))
			Audio.move_left()
		ACTIONS.DOWN:
			translate(Vector2(0, 16))
			Audio.move_down()
		ACTIONS.UP:
			translate(Vector2(0, -16))
			Audio.move_down()
	
	var childs = get_child_count()
	for i in range(childs):
		var child = get_child(i)
		if child.has_method("change_sprite"):
			child.change_sprite()

