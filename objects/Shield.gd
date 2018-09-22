extends Node2D

var hp = 8

func take_damage(damage):
	hp -= damage
	if hp <= 0:
		queue_free()
		return 1

	select_sprite()
	return hp
	
func select_sprite():
	var frame = 4
	match hp:
		7: frame = 1
		6: frame = 1
		5: frame = 2
		4: frame = 2
		3: frame = 3
		2: frame = 3
			
	$Sprite.frame = frame

func _on_Area2D_area_entered(area):
	var parent = area.get_parent()
	if parent.has_method("take_damage"):
		parent.take_damage(10)
