extends Node2D

const ColorBlinkLabel = preload("res://ui/ColorBlinkLabel.tscn")
const SPEED = 150

var dir = -1

func _ready():
	Audio.ufo_engine()

func _process(delta):
	translate(Vector2(SPEED * dir, 0) * delta)
	if (position.x > get_viewport().size.x + 32) || (position.x < -32):
		queue_free()
		
func _exit_tree():
	var label = ColorBlinkLabel.instance()
	label.rect_position = Vector2(position.x - 16, position.y - 8)
	label.text = "100"
	label.selfDestroy = 1
	get_parent().add_child(label)

func take_damage(damage):
	State.add_score(100)
	Audio.explosion()
	queue_free()
		
	return 1
