extends CanvasLayer

var time = 0
export(int) var blinkTime = 0

func _process(delta):
	time += delta
	if time > 1.5:
		get_tree().paused = false
		queue_free()

	blinkTime += delta
	if blinkTime > 0.1:
		blinkTime = 0
		$Ready.visible = !$Ready.visible