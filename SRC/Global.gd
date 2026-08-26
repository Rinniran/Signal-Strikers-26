extends Node

var crt = false
var players = []
enum gm 
{
	
	STORY,
	VERSUS,
	TDM,
	CTF
	
} 

var gamemode = gm.VERSUS

@onready var pp = preload("uid://bsc75hoq7yhol").instantiate()

func _ready() -> void:
	add_child(pp)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("crt"):
		crt = !crt
