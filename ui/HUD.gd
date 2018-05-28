extends CanvasLayer

func _process(delta):
	$Score.text = str(State.score)
	$Lifes.text = str(State.lifes)
