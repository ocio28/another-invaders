extends Node2D

export(String) var text = ""
export(float) var blinkTime = 0.1
export(bool) var autostart = true
var time = 0
var blink = true

var selfDestroy = 0
var destroy = 0

func _ready():
	$Label.text = text

func _process(delta):
	if !autostart:
		return
	time += delta
	if time > 0.05:
		time = 0
		var c
		if blink:
			c = Color(1, 0, 0)
		else:
			c = Color(1, 1, 1)
		blink = !blink
		$Label.set("custom_colors/font_color", c)
		
	if selfDestroy != 0:
		destroy += delta
	if destroy > selfDestroy:
		queue_free()
