extends Node2D

export(PackedScene) var Label

var spam = 0

func _ready():
	State.top_scores.sort_custom(MyCustomSorter, "sort")

func _process(delta):
	if Input.is_action_just_pressed("ui_shoot"):
		State.goto_scene("Title")

func _on_SpamScore_timeout():
	if State.top_scores.size() == 0:
		$Empty.visible = true
		return
	
	if spam < 5 && spam < State.top_scores.size():
		var s = State.top_scores[spam]
		var score = Label.instance()
		score.text = str(spam + 1) + " " + s.name + " " + State.to_time(s.time) + "  " + str(s.score)
		score.rect_position = Vector2($N.rect_position.x, $N.rect_position.y + (32 * (spam + 1)))
		add_child(score)
		spam += 1

class MyCustomSorter:
	static func sort(a, b):
		if b.score < a.score:
			return true
		return false

func _on_TitleTimer_timeout():
	State.goto_scene("Title")
