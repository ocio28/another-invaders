extends Node2D

const SPEED = Vector2(0, -1000)
var shoot = false

var shipPositions = []
var index = 2
var pressed =  false

#var output = []

func _ready():
	#check_coins()
	shipPositions.append(Vector2($SoundConfig.position.x, $Ship.position.y))
	shipPositions.append(Vector2($Fullscreen.position.x + 50, $Ship.position.y))
	shipPositions.append(Vector2($Play.position.x, $Ship.position.y))
	shipPositions.append(Vector2($Exit.position.x, $Ship.position.y))

func _process(delta):
	"""if output.size() != 0:
		var coins = int(output[0])
		if coins == 0:
			return
			
	$Ship.visible = true"""
	if (Input.is_action_just_pressed("ui_start") || Input.is_action_just_pressed("ui_shoot")) && $Shoot != null:
		pressed = true
		shoot = true
		$Shoot.position = shipPositions[index]
		$Shoot.visible = true
		if State.config.sound:
			$ShootStream.play()
		
	if Input.is_action_just_pressed("ui_right"):
		pressed = true
		index += 1
		if index > shipPositions.size() - 1:
			index = shipPositions.size() - 1
		
	if Input.is_action_just_pressed("ui_left"):
		pressed = true
		index -= 1
		if index < 0:
			index = 0
		
	$Ship.position = shipPositions[index]
	if shoot && $Shoot != null && $Shoot.visible:
		$Shoot.translate(SPEED * delta)

func _on_RankingTimer_timeout():
	if !pressed:
		if State.demoPlay:
			State.goto_scene("DemoPlay")
		else:
			State.goto_scene("Ranking")
		State.demoPlay = !State.demoPlay
	else:
		pressed = false

func check_coins():
	pass
	#var output = []
	#var pid = OS.execute('node', ['/home/ocio/workspace/arcade/game-wallet', 'coins'], false, output)
	#var coins = output[0]
	#print('pid', pid, output)

func _on_CheckCoins_timeout():
	check_coins()
