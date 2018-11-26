extends Node2D

enum ACTIONS {LEFT, RIGHT, UP, DOWN, STAND}
enum PATTERNS {BASIC, B2, H1, H2, C1, C2, STATIC}

const BASIC = [RIGHT, RIGHT, RIGHT, DOWN, LEFT, LEFT, LEFT, DOWN]
const B2 = [LEFT, LEFT, LEFT, DOWN, RIGHT, RIGHT, RIGHT, DOWN]
const C1 = [RIGHT, LEFT, LEFT, LEFT, DOWN, LEFT, RIGHT, RIGHT, RIGHT, DOWN]
const C2 = [LEFT, RIGHT, RIGHT, RIGHT, DOWN, RIGHT, LEFT, LEFT, LEFT, DOWN]
const H1 = [RIGHT, RIGHT, LEFT, LEFT, DOWN]
const H2 = [LEFT, RIGHT, RIGHT, LEFT, DOWN]
const STATIC = [STAND, STAND, STAND, DOWN]

export(PATTERNS) var pattern
var current = BASIC

var index = 0
var time = 0
var current_timeout = 0.8
var count = 0

func _ready():
	match pattern:
		PATTERNS.BASIC: current = BASIC
		PATTERNS.B2: current = B2
		PATTERNS.H1: current = H1
		PATTERNS.C1: current = C1
		PATTERNS.C2: current = C2
		PATTERNS.STATIC: current = STATIC

func _process(delta):
	time += delta
	if time > current_timeout:
		timeout()
		
func timeout():
	time = 0
	var action = current[index]
	index += 1
	if index == current.size():
		index = 0
	move(action)
	count += 1
	if count > 6 && current_timeout > 0.3:
		count = 0
		current_timeout -= 0.1
		

func move(action):
	var pos = Vector2(0, 0)
	match action:
		ACTIONS.RIGHT: 
			pos = Vector2(16, 0)
		ACTIONS.LEFT:
			pos = Vector2(-16, 0)
		ACTIONS.DOWN:
			pos = Vector2(0, 16)
		ACTIONS.UP:
			pos = Vector2(0, -16)
	
	"""var ydol = get_node("Ydol")
	if ydol != null:
		ydol.move(pos)"""
	#var childs = $Creatures.get_child_count()
	var childs = get_child_count()
	for i in range(childs):
		var child = get_child(i)
		if child.has_method("move"):
			child.move(pos)
		if child.has_method("change_sprite"):
			child.change_sprite()

