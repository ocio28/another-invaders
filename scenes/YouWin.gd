extends Node2D

var ready = false

func _ready():
	$Score.text = str(State.score)
	$Lifes.text = str(State.lifes)
	$Time.text = State.to_time(State.stage_time)

func _process(delta):
	if ready && Input.is_action_just_pressed("ui_shoot"):
		State.next_stage()


func _on_Timer_timeout():
	$Continue.visible = true
	$Continue.autostart = true
	ready = true
