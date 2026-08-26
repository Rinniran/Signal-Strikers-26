extends Node3D
class_name Hitbox

@export var lifetime = 25
@export var damage = 2
@export var knockback = 0.3
@export var hitscale = 1
@export var parent:Node #The node that's in this variable doesn't react to it

var lifetimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale = Vector3(hitscale,hitscale,hitscale)
	lifetimer = lifetime
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	lifetimer -= 1
	if lifetimer <= 0:
		queue_free()
	
	pass
