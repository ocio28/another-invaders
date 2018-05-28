extends Label

export(float) var blinkTime = 0.1
export(bool) var autostart = true
export(int) var selfDestroy = 0
export(Color) var origin = Color(1, 1, 1)
export(Color) var target = Color(1, 0, 0)

var time = 0
var destroy = 0
var blink = true

func _process(delta):
	if !autostart:
		return
	time += delta
	if time > 0.05:
		time = 0
		var c
		if blink:
			c = origin
		else:
			c = target
		blink = !blink
		set_color(c)
		
	if selfDestroy != 0:
		destroy += delta
		if destroy > selfDestroy:
			queue_free()

func play_blink():
	autostart = true
	
func stop_blink():
	autostart = false
	set_color(origin)
	
func set_color(color):
	self.set("custom_colors/font_color", color)