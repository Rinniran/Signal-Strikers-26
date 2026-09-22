extends SubViewportContainer

const GAME_CAM = preload("uid://bnxbd380sviwo")

@onready var subview: SubViewport = $SubViewport

var player: Character:
	set(c):
		player = c
		subview.add_child(player)

var enemy: Character:
	set(e):
		if player == null:
			push_error("Attempted to set this view's Enemy before Player! Skipping")
			return
		enemy = e
		var cam = GAME_CAM.instantiate()
		cam.player = player
		player.camera = cam
		cam.target = enemy
		subview.add_child(cam)

func _ready() -> void:
	subview.world_3d = get_viewport().world_3d
