extends Node

const RIAN = preload("uid://bkslkndth6h2r")
const ZAPPY = preload("uid://c5u83egpcslmo")

const PLAYER_VIEW = preload("uid://dwo1ghv176jy3")
@onready var container: HBoxContainer = $container
@onready var spawnpoints: Array[Node3D] = [$spawnA, $spawnB]

func _ready() -> void:
	var p1 = RIAN.instantiate()
	var p2 = ZAPPY.instantiate()
	if Input.get_connected_joypads().size() == 1:
		p1.ControllerIndex = -1
		p2.ControllerIndex = 0
	elif Input.get_connected_joypads().size() > 1:
		p1.ControllerIndex = 0
		p2.ControllerIndex = 1
	setup([p1, p2])

# Set up players and views. Only supports 2 players at the moment, might change it later
func setup(players: Array[Character]) :
	for i in range(players.size()):
		var pv := PLAYER_VIEW.instantiate()
		container.add_child(pv)
		pv.player = players[i]
		pv.enemy = players[i - 1] #Using the wrapping of negative array indices we can just fetch the other player in the array with this
		players[i].global_position = spawnpoints[i].global_position
