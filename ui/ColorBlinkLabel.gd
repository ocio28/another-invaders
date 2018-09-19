extends Label

export(float) var blinkTime = 0.1
export(bool) var autostart = true
export(bool) var selfDestroy = false
export(Color) var origin = Color(1, 1, 1)
export(Color) var target = Color(1, 0, 0)

var time = 0
var blink = true
var blinking = 0

func _process(delta):
	if !autostart:
		set_color(origin)
		return
	
	blinking += delta
	if blinking > 0.5:
		autostart = false
		blinking = 0
		if selfDestroy:
			queue_free()
		
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
	

func play_blink():
	autostart = true
	if State.config.sound:
		$Audio.play()
	
func stop_blink():
	autostart = false
	set_color(origin)
	
func set_color(color):
	self.set("custom_colors/font_color", color)