extends Node2D

var shipPositions = []
var index = 0
var pressed= false
var shooting = false

func _ready():
	shipPositions.append(Vector2($Ship.position.x, $PlayLabel.rect_position.y))
	shipPositions.append(Vector2($Ship.position.x, $ScoresLabel.rect_position.y))
	shipPositions.append(Vector2($Ship.position.x, $FullscreenLabel.rect_position.y))
	shipPositions.append(Vector2($Ship.position.x, $SoundLabel.rect_position.y))
	shipPositions.append(Vector2($Ship.position.x, $ExitLabel.rect_position.y))
	$Ship.position.y = $PlayLabel.rect_position.y + 8
	if State.config.sound:
		$SoundLabel.text = "sonido"
	else:
		$SoundLabel.text = "mute"

func _process(delta):
	if shooting:
		$Ship/Shoot.translate(Vector2(0, -20))
	if not $ActionTimeout.is_stopped():
		return

	if (Input.is_action_just_pressed("ui_start") || Input.is_action_just_pressed("ui_shoot")):
		pressed = true
		shooting = true
		$Ship/Shoot.visible = true
		$Ship/Shoot.position.y = 0
		Audio.shoot()
		$ActionTimeout.start()
		match index:
			0: $PlayLabel.play_blink()
			1: $ScoresLabel.play_blink()
			2: $FullscreenLabel.play_blink()
			3: $SoundLabel.play_blink()
			4: $ExitLabel.play_blink()
		
	if Input.is_action_just_pressed("ui_down"):
		pressed = true
		index += 1
		if index > shipPositions.size() - 1:
			index = 0
		
	if Input.is_action_just_pressed("ui_up"):
		pressed = true
		index -= 1
		if index < 0:
			index = shipPositions.size() - 1
			
	$Ship.position.y = shipPositions[index].y + 8

func _on_RankingTimer_timeout():
	if !pressed:
		State.goto_scene("DemoPlay")
	else:
		pressed = false


func _on_ActionTimeout_timeout():
	match index:
		0: State.start_new_game()
		1: State.goto_scene("Ranking")
		2: fullscreen()
		3: sound_change()
		4: get_tree().quit()
	
func sound_change():
	State.config.sound = !State.config.sound
	if State.config.sound:
		$SoundLabel.text = "sonido"
	else:
		$SoundLabel.text = "mute"
	State.save_game()

func fullscreen():
	OS.window_fullscreen = !OS.window_fullscreen
	if !OS.window_fullscreen:
		OS.window_size = Vector2(State.config.viewport.x ,State.config.viewport.y)
		OS.request_attention()
	
	if OS.window_fullscreen:
		$FullscreenLabel.text = "window"
	else:
		$FullscreenLabel.text = "fullscreen"