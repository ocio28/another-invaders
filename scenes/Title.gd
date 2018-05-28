extends Node2D

const SPEED = Vector2(0, -800)
var shoot = false

var shipPositions = []
var index = 1
var pressed =  false

func _ready():
	shipPositions.append(Vector2($Fullscreen.position.x, $Ship.position.y))
	shipPositions.append(Vector2($Play.position.x, $Ship.position.y))
	shipPositions.append(Vector2($SoundConfig.position.x, $Ship.position.y))

func _process(delta):
	if (Input.is_action_just_pressed("ui_start") || Input.is_action_just_pressed("ui_shoot")) && $Shoot != null:
		pressed = true
		shoot = true
		$Shoot.position = shipPositions[index]
		$Shoot.visible = true
		
	if Input.is_action_just_pressed("ui_right") && $StartTimer.is_stopped():
		pressed = true
		index += 1
		if index > shipPositions.size() - 1:
			index = shipPositions.size() - 1
		
	if Input.is_action_just_pressed("ui_left") && $StartTimer.is_stopped():
		pressed = true
		index -= 1
		if index < 0:
			index = 0
		
	$Ship.position = shipPositions[index]
	if shoot && $Shoot != null:
		$Shoot.translate(SPEED * delta)

func _on_Area2D_area_entered(area):
	area.get_parent().queue_free()
	$Play.autostart = true
	$StartTimer.start()

func _on_StartTimer_timeout():
	State.start_new_game()


func _on_RankingTimer_timeout():
	if !pressed:
		if State.demoPlay:
			State.goto_scene("DemoPlay")
		else:
			State.goto_scene("Ranking")
		State.demoPlay = !State.demoPlay
	else:
		pressed = false
