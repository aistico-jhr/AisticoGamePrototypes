extends Area2D

export var PlayerIndex : int = 0
var keys = ["ui_left", "ui_down", "ui_right"]
onready var gameController = get_parent()

func _ready():
	position.x = get_viewport_rect().size.x / 6 * (1 + 2 * PlayerIndex)

func _physics_process(_delta):
	if Input.is_action_just_pressed(keys[PlayerIndex]):
		if visible:
			hide()
		else: 
			show()


func _on_Player_body_entered(body):
	if visible and body.is_in_group("item"):
		if body.Score > 0: gameController.inc_combo()
		else: gameController.lose_combo()
		gameController.change_points(body.Score, PlayerIndex)
		gameController.was_row_learned(body.Score, body.rowData)
		body.queue_free()
