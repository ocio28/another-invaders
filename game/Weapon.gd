extends Node2D

export(PackedScene) var bullet
export(float) var cooldown = 1

var cooldownTime = 0
var inCooldown = false

func _process(delta):
	if inCooldown:
		cooldownTime += delta
		if cooldownTime > cooldown:
			inCooldown = false
			cooldownTime = 0
			
func shoot():
	if not inCooldown:
		var instance = bullet.instance()
		instance.position = Vector2(global_position.x, global_position.y)
		add_object(instance)
		inCooldown = true
		
func add_object(obj):
	get_tree().root.add_child(obj)