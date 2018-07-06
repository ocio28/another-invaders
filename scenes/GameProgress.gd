extends Node2D

const SPEED = Vector2(0, -1000)
var shoot = false

var shipPositions = []
var index = 1
var pressed =  false

func _ready():
	shipPositions.append(Vector2($Options/Back.position.x, $Ship.position.y))
	shipPositions.append(Vector2($Options/TierraLabel.position.x, $Ship.position.y))
	if State.progress > 10:
		shipPositions.append(Vector2($Options/LunaLabel.position.x, $Ship.position.y))
	if State.progress > 20:
		shipPositions.append(Vector2($Options/MarteLabel.position.x, $Ship.position.y))
	if State.progress > 30:
		shipPositions.append(Vector2($Options/JupiterLabel.position.x, $Ship.position.y))
	
func _process(delta):
	if (Input.is_action_just_pressed("ui_start") || Input.is_action_just_pressed("ui_shoot")) && $Shoot != null:
		pressed = true
		shoot = true
		$Shoot.position = shipPositions[index]
		$Shoot.visible = true
		Audio.shoot()
		
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
	if shoot && $Shoot != null:
		$Shoot.translate(SPEED * delta)