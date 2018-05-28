extends Node2D

export(Vector2) var speed = Vector2(0, 200)
export(int) var hp = 1

func _process(delta):
	translate(speed * delta)
	if position.y < 0 || position.y > get_viewport().size.y:
		queue_free()


func _on_Area2D_area_entered(area):
	area.get_parent().take_damage()
	hp -= 1
	if hp == 0:
		queue_free()