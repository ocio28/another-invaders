extends Label

export(float) var blinkTime = 0.1
export(float) var selfDestroy = 0
export(bool) var autostart = true

var time = 0
var destroy = 0

func _process(delta):
	if !autostart:
		return

	time += delta
	if time > blinkTime:
		time = 0
		self.visible = !self.visible
		
	if selfDestroy != 0:
		destroy += delta
		if destroy > selfDestroy:
			queue_free()