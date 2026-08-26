extends Marker3D

@export var target:Node
@export var player:Node

var sensitivity = 500
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	position.x = player.position.x
	position.z = player.position.z
	position.y = player.position.y + 2.5
	if target != null:
		_look_at_target_interpolated(.1)
	else:
		#if Input.is_action_pressed("camleft"):
			#rotation.y += .06
		#if Input.is_action_pressed("camright"):
			#rotation.y -= .06
			pass
		


func _look_at_target_interpolated(weight:float) -> void:
	var xform := transform # your transform
	xform = xform.looking_at(target.global_position,Vector3.UP)
	transform = transform.interpolate_with(xform,weight)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x / sensitivity
		rotation.x -= event.relative.y / sensitivity
		rotation.x = clamp(rotation.x, deg_to_rad(-45), deg_to_rad(90))
