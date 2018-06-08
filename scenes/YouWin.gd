extends Node2D

func _ready():
	$Score.text = str(State.score)
	$Lifes.text = str(State.lifes)
	$Time.text = State.to_time(State.stage_time)

func _on_Timer_timeout():
	State.next_stage()
