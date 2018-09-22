extends CanvasLayer

func _ready():
	weapon()

func _process(delta):
	$Score.text = str(State.score)
	$Lifes.text = str(State.lifes)
	weapon()

func weapon():
	if State.player.weapon != 0:
		$Ammo.visible = true
		$Ammo.text = str(State.player.bullets)
	else:
		$Ammo.visible = false