extends Node2D

enum ACTIONS {TIERRA, LUNA, MARTE, JUPITER}
export(ACTIONS) var action = ACTIONS.TIERRA
export(String) var text = ""

func _ready():
	$Label.text = text

func _on_Area2D_area_entered(area):
	$Label.play_blink()
	$OffTimer.start()

func _on_OffTimer_timeout():
	$Label.stop_blink()
	State.do_action(action)
