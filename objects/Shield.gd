extends Node2D

var hp = 4

func take_damage(damage):
	hp -= damage
	if hp <= 0:
		queue_free()
		return 1
	else:
		$Sprite.frame += 1
	return hp