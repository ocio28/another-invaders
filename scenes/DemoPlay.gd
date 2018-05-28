extends Node2D

enum ACTIONS {RIGHT, LEFT, SHOOT}
var actionTime = 0
var actions = [{
	"time": 0.5,
	"duration": 0.3,
	"action": ACTIONS.RIGHT
}, {
	"time": 0.9,
	"duration": 0.2,
	"action": ACTIONS.RIGHT
}, {
	"time": 1.1,
	"duration": 0,
	"action": ACTIONS.SHOOT
}, {
	"time": 1.1,
	"duration": 0.5,
	"action": ACTIONS.LEFT
}, {
	"time": 1.6,
	"duration": 0,
	"action": ACTIONS.SHOOT
}, {
	"time": 1.6,
	"duration": 1,
	"action": ACTIONS.RIGHT
}, {
	"time": 2.6,
	"duration": 0,
	"action": ACTIONS.SHOOT
}, {
	"time": 2.8,
	"duration": 0.5,
	"action": ACTIONS.LEFT
}, {
	"time": 3.3,
	"duration": 0,
	"action": ACTIONS.SHOOT
}, {
	"time": 3.5,
	"duration": 0.3,
	"action": ACTIONS.LEFT
}, {
	"time": 4,
	"duration": 0.5,
	"action": ACTIONS.LEFT
}, {
	"time": 4.5,
	"duration": 0,
	"action": ACTIONS.SHOOT
}, {
	"time": 4.6,
	"duration": 0.2,
	"action": ACTIONS.RIGHT
}, {
	"time": 4.9,
	"duration": 0.2,
	"action": ACTIONS.RIGHT
}, {
	"time": 5.1,
	"duration": 0,
	"action": ACTIONS.SHOOT
}, {
	"time": 5.1,
	"duration": 0.2,
	"action": ACTIONS.LEFT
}, {
	"time": 5.5,
	"duration": 0.2,
	"action": ACTIONS.LEFT
}, {
	"time": 5.7,
	"duration": 0.5,
	"action": ACTIONS.RIGHT
}, {
	"time": 6.2,
	"duration": 0,
	"action": ACTIONS.SHOOT
}, {
	"time": 6.3,
	"duration": 0.2,
	"action": ACTIONS.RIGHT
}, {
	"time": 6.6,
	"duration": 0.3,
	"action": ACTIONS.LEFT
}, {
	"time": 6.9,
	"duration": 0,
	"action": ACTIONS.SHOOT
}, {
	"time": 7,
	"duration": 1,
	"action": ACTIONS.LEFT
}]
var current
var currentActionTime = 0

func _ready():
	current = actions.pop_front()

func _process(delta):
	actionTime += delta
	if current == null || !$Ship.alive:
		return
		
	if actionTime > current.time:
		currentActionTime += delta
		match current.action:
			ACTIONS.RIGHT:
				$Ship.translate(Vector2($Ship.SPEED, 0) * delta)
			ACTIONS.LEFT:
				$Ship.translate(Vector2(-$Ship.SPEED, 0) * delta)
			ACTIONS.SHOOT:
				$Ship.shoot()
				
		if currentActionTime > current.duration:
			current = actions.pop_front()
			currentActionTime = 0
			
	if Input.is_action_just_pressed("ui_start") || Input.is_action_just_pressed("ui_shoot"):
		State.goto_scene("Title")


func _on_EndTimer_timeout():
	State.goto_scene("Title")
