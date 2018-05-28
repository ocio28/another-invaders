extends Node2D

const CHARS = "abcdefghijkmnlopqrstuvwxyz? _"
var charIndex = 0
var enter_name = false
var enters = 0

func _ready():
	$Score.text = str(State.score)
	$Time.text = State.to_time(State.game_time)
	$Name.text = "a         "

func _process(delta):
	if enter_name && Input.is_action_just_pressed("ui_shoot"):
		finish_game()
		
	if Input.is_action_just_pressed("ui_start") && !enter_name:
		finish_enter_name()
		
	if Input.is_action_just_pressed("ui_shoot") && !enter_name:
		enters += 1
		if enters == $Name.text.length():
			finish_enter_name()
		else:
			$Name.text[enters] = CHARS[charIndex]
		
	if Input.is_action_just_pressed("ui_up") && !enter_name:
		charIndex += 1
		if charIndex == CHARS.length():
			charIndex = 0
		$Name.text[enters] = CHARS[charIndex]
	if Input.is_action_just_pressed("ui_down") && !enter_name:
		charIndex -= 1
		if charIndex == -1:
			charIndex = CHARS.length() - 1
		$Name.text[enters] = CHARS[charIndex]
		
	if Input.is_action_just_pressed("ui_left") && !enter_name:
		enters -= 1
		if enters < 0:
			enters = $Name.text.length() - 1
	
	if Input.is_action_just_pressed("ui_right") && !enter_name:
		enters += 1
		if enters == $Name.text.length():
			enters = 0
					
	if $Index != null:
		$Index.rect_position = Vector2($Name.rect_position.x + (enters * 16), $Index.rect_position.y)

func finish_enter_name():
	enter_name = true
	$Continue.autostart = true
	$Continue.visible = true
	$Index.queue_free()
	
func finish_game():
	State.save_game($Name.text)
	State.goto_scene("Ranking")

func _on_Timer_timeout():
	finish_game()
