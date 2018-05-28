extends Node2D

var time = 0
var blink = false

func _process(delta):
	time += delta
	if time > 0.05:
		time = 0
		blink = !blink
		if blink:
			$Sprite.modulate.g = 0
			$Sprite.modulate.b = 0
		else:
			$Sprite.modulate.g = 1
			$Sprite.modulate.b = 1
	
func _on_Timer_timeout():
	queue_free()
