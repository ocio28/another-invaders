tool
extends Node2D

export(int) var width = 2
export(int) var height = 2

func _ready():
	var pivot = $Top_Left.position
	$Top_Right.position = Vector2(pivot.x * width, pivot.y)
	$Bottom_Left.position = Vector2(pivot.x, pivot.y * height)
	$Bottom_Right.position = Vector2(pivot.x * width, pivot.y * height)
	
	#if width - 2 != 0:
	#	for i in range(2, width):
	#		print(i)
	#		var h1 = $Horizontal.duplicate()
	#		h1.position = Vector2(pivot.x * (i + 1), pivot.y)
			

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
