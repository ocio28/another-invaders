extends Node2D

const SPEED = Vector2(0, -800)
var shoot = false

var shipPositions = []
var index = 0
var pressed =  false

func _ready():
	for child in $Options.get_children():		
		shipPositions.append(Vector2(child.position.x, $Ship.position.y))
	#shipPositions.append(Vector2($TierraLabel.position.x, $Ship.position.y))
	#shipPositions.append(Vector2($LunaLabel.position.x, $Ship.position.y))
	#shipPositions.append(Vector2($MarteLabel.position.x, $Ship.position.y))
	#shipPositions.append(Vector2($JupiterLabel.position.x, $Ship.position.y))
	
func _process(delta):
	if (Input.is_action_just_pressed("ui_start") || Input.is_action_just_pressed("ui_shoot")) && $Shoot != null:
		pressed = true
		shoot = true
		$Shoot.position = shipPositions[index]
		$Shoot.visible = true
		
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