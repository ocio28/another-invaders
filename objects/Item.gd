extends Node2D

const SPEED = Vector2(0, 200)
export(int) var bullets
export(int) var weapon

func _process(delta):
	translate(SPEED * delta)
	if position.y > get_viewport().size.y:
		queue_free()
