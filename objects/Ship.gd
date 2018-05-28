extends Node2D

export(bool) var playable = true

const Explosion = preload("res://objects/Explosion.tscn")
const Bullet = preload("res://objects/Bullet.tscn")
const FastBullet = preload("res://objects/FastBullet.tscn")
const SparkBullet = preload("res://objects/SparkBullet.tscn")
const StrongBullet = preload("res://objects/StrongBullet.tscn")
const SPEED = 150

var bullets = 0
var weapon = 0
var alive = true
var shooting = false
var iframeTime = 0

func _process(delta):
	if alive:
		if playable:
			var left = Input.is_action_pressed("ui_left")
			var right = Input.is_action_pressed("ui_right")
			var action = Input.is_action_just_pressed("ui_shoot")
			
			if left:
				translate(Vector2(-SPEED, 0) * delta)
			if right:
				translate(Vector2(SPEED, 0) * delta)
			if action && !shooting:
				shoot()
			
		if position.x > get_viewport().size.x - 16:
			position.x = get_viewport().size.x - 16
		if position.x < 16:
			position.x = 16
		if !$IframeTimeout.is_stopped():
			iframeTime += delta
			if iframeTime > 0.05:
				iframeTime = 0
				visible = !visible
		else:
			visible = true

func shoot():
	var bullet
	match weapon:
		0: bullet = Bullet.instance()
		1: bullet = FastBullet.instance()
		2: bullet = SparkBullet.instance()
		3: bullet = StrongBullet.instance()
	
	bullet.set_position(Vector2(position.x, position.y -16))
	get_parent().add_child(bullet)
	shooting = true
	bullets -= 1
	$Timer.start()
	if weapon != 0 && bullets <= 0:
		weapon = 0
	
func take_damage():
	if !$IframeTimeout.is_stopped() || !alive:
		return
	visible = false
	alive = false
	var explosion = Explosion.instance()
	explosion.set_position(Vector2(position.x, position.y))
	get_parent().add_child(explosion)
	$RespawnTimer.start()
	
func _on_Timer_timeout():
	shooting = false

func _on_Area2D_area_entered(area):
	if area.is_in_group("item") && alive:
		weapon = area.get_parent().weapon
		bullets = area.get_parent().bullets
		area.get_parent().queue_free()

func _on_RespawnTimer_timeout():
	State.player_take_damage()
	visible = true
	alive = true
	active_iframe()

func active_iframe():
	iframeTime = 0
	$IframeTimeout.start()
