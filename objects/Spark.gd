extends Node2D

var time = 0

func _process(delta):
	time += delta
	if time > 0.05:
		time = 0
		if $Sprite.frame == 0:
			$Sprite.frame = 1
		else:
			$Sprite.frame = 0

func _on_Timer_timeout():
	queue_free()

func _on_Area2D_area_entered(area):
	area.get_parent().take_damage(1)
