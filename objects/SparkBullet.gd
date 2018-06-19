extends Node2D

export(Vector2) var speed = Vector2(0, 200)
const Spark = preload("res://objects/Spark.tscn")
var anim = 0

func _process(delta):
	anim += delta
	if anim > 0.05:
		anim = 0
		if $Sprite.frame == 0:
			$Sprite.frame = 1
		else:
			$Sprite.frame = 0

	translate(speed * delta)
	if position.y < 0 || position.y > get_viewport().size.y - 32:
		spark()
		
func spark():
	var spark = Spark.instance()
	spark.position = Vector2(position.x, position.y - 16)
	get_parent().add_child(spark)
	queue_free()

func _on_Area2D_area_entered(area):
	area.get_parent().take_damage(1)
	spark()
