extends Node2D

const Explosion = preload("res://objects/Explosion.tscn")

export(int) var score = 10
export(float) var dropRate = 0.3
export(float) var baseCooldown = 3
export(PackedScene) var Item
export(PackedScene) var bullet

var step = 1
var dir = 1

func _ready():
	State.enemies += 1
	start_cooldown()
	
func start_cooldown():
	$Cooldown.wait_time = baseCooldown * randf() + 1
	$Cooldown.start()
	
func shoot():
	var shoot = bullet.instance()
	shoot.position = Vector2(global_position.x, global_position.y)
	add_object(shoot)
	start_cooldown()
	
func change_sprite():
	if $Sprite.frame == 0:
		$Sprite.frame = 1
	else:
		$Sprite.frame = 0
	
func _exit_tree():
	var explosion = Explosion.instance()
	explosion.set_position(Vector2(global_position.x, global_position.y))
	add_object(explosion)
	
	if randf() < dropRate:
		var item = Item.instance()
		item.set_position(Vector2(global_position.x, global_position.y))
		add_object(item)
	Audio.destroy()
	
func add_object(obj):
	get_tree().root.add_child(obj)

func _on_Cooldown_timeout():
	shoot()

func take_damage(damage):
	State.kill_enemy(score)
	queue_free()
	return 1