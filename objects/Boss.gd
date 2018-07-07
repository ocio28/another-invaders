extends Node2D

export(int) var maxHp = 1

onready var hp = maxHp

#func wait_time():
#	waitTime = (randi() % 3 + 1) + randf()

func _ready():
	State.enemies += 1
	
func shoot():
	var count = $Weapons.get_child_count()
	var pick = randi() % count
	
	$Weapons.get_child(pick).shoot()
	
func take_damage(damage):
	hp -= damage
	if hp == 0:
		State.kill_enemy(200)
		queue_free()
	return maxHp

func change_sprite():
	if $Sprite.frame == 0:
		$Sprite.frame = 1
	else:
		$Sprite.frame = 0

func _on_Shoot_timeout():
	shoot()
