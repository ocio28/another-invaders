extends Node2D

const ColorBlinkLabel = preload("res://ui/ColorBlinkLabel.tscn")
var dir = -1
onready var initialPosition = Vector2(position.x ,position.y)

func _ready():
	start_timer()

func _process(delta):
	if $Timer.is_stopped():
		translate(Vector2(100 * dir, 0) * delta)
		if (position.x > get_viewport().size.x + 64) || (position.x < -64):
			start_timer()

func take_damage():
	var label = ColorBlinkLabel.instance()
	label.rect_position = Vector2(position.x - 16, position.y - 8)
	label.text = "100"
	label.selfDestroy = 1
	get_parent().add_child(label)
	position = Vector2(initialPosition.x, initialPosition.y)
	start_timer()
	State.add_score(100)

func _on_Timer_timeout():
	dir *= -1
	$Timer.stop()

func start_timer():
	$Timer.wait_time = randi() % 2 + 4
	$Timer.start()