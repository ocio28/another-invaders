extends Node2D

const ColorBlinkLabel = preload("res://ui/ColorBlinkLabel.tscn")
const SPEED = 150

onready var LEFT_POSITION = Vector2(position.x + 32, position.y)
onready var RIGHT_POSITION = Vector2(get_viewport().size.x, position.y)
#onready var initialPosition = Vector2(position.x ,position.y)

var dir = -1

func _ready():
	start_timer()

func _process(delta):
	if $Timer.is_stopped():
		translate(Vector2(SPEED * dir, 0) * delta)
		if (position.x > get_viewport().size.x + 64) || (position.x < -64):
			start_timer()
		if not $EngineStream.playing && State.config.sound:
			$EngineStream.play(0)
	else:
		$EngineStream.stop()

func take_damage():
	var label = ColorBlinkLabel.instance()
	label.rect_position = Vector2(position.x - 16, position.y - 8)
	label.text = "100"
	label.selfDestroy = 1
	get_parent().add_child(label)
	position = Vector2(-128, LEFT_POSITION.y)
	start_timer()
	State.add_score(100)
	if State.config.sound:
		$DestroyStream.play()

func _on_Timer_timeout():
	var spawn = randi() % 10
	if spawn < 3:
		start_timer()
	else:
		var direction = randi() % 2
		if direction == 0:
			dir = 1
			position = LEFT_POSITION
		else:
			dir = -1
			position = RIGHT_POSITION

func start_timer():
	$Timer.wait_time = randi() % 6 + 2
	$Timer.start()

func _on_EngineStream_finished():
	pass # replace with function body
