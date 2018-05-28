extends Node2D

var hp = 4

func take_damage():
	hp -= 1
	if hp == 0:
		queue_free()
	else:
		$Sprite.frame += 1