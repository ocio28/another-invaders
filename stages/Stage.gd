extends Node2D

var time = 0

#func _ready():
	#State.enemies = get_node("Enemies").get_child_count()

func _process(delta):
	if State.enemies == 0:
		time += delta
		if time > 1:
			State.you_win()
