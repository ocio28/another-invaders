extends Node2D

const Explosion = preload("res://objects/Explosion.tscn")
const RIGHT = Vector2(16, 0)
const LEFT = Vector2(-16, 0)
const DOWN = Vector2(0, 32)

export(int) var score = 10
export(float) var dropRate = 0.3
export(PackedScene) var Item
export(PackedScene) var bullet

var step = 1
var dir = 1
#var current = RIGHT

func _ready():
	State.enemies += 1
	start_cooldown()
	
func start_cooldown():
	$Cooldown.wait_time = 3 * randf() + 1
	$Cooldown.start()
	
func shoot():
	var shoot = bullet.instance()
	shoot.position = Vector2(position.x, position.y)
	get_parent().add_child(shoot)
	start_cooldown()
	
func move(action):
	match action:
		"RIGHT": translate(RIGHT)
		"LEFT": translate(LEFT)
		"DOWN": translate(DOWN)

func _on_Timer_timeout():
	var y = 0
	var x = 16
	
	if step % 6 == 0:
		dir *= -1
		y = 20
		x = 0
		if $MoveTimer.wait_time > 0.2:
			$MoveTimer.wait_time -= 0.1

	translate(Vector2(x * dir, y))
	if $Sprite.frame == 0:
		$Sprite.frame = 1
	else:
		$Sprite.frame = 0
	step += 1
	if position.y > get_viewport().size.y - 64:
		State.goto_scene("GameProgress")
	
func _exit_tree():
	var explosion = Explosion.instance()
	explosion.set_position(Vector2(position.x, position.y))
	get_parent().add_child(explosion)
	
	if randf() < dropRate:
		var item = Item.instance()
		item.set_position(Vector2(position.x, position.y))
		get_parent().add_child(item)
	

func _on_Cooldown_timeout():
	shoot()

func take_damage():
	State.kill_enemy(score)
	queue_free()