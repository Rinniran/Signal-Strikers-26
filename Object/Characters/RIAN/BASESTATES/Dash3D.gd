@tool
extends BaseState

var moverandomizer = RandomNumberGenerator.new()
var movechoice
var aftimagetimer = 2
var MSPEED = 25


func _enter(data = {}):
	super._enter(data)
	if not root.is_on_floor():
		root.dashes -= 1
	root.GRAV_ENABLED = false
	root.CAN_MOVE = false
	root.velocity.y = 0
	


func _step():
	super._step()
	
	
	#root.hurbcol.disabled = true
	
	var Kup = Input.is_action_pressed("Forward")
	var Kdown = Input.is_action_pressed("Back")
	var Kleft = Input.is_action_pressed("Left")
	var Kright = Input.is_action_pressed("Right")
	
	
	if Kleft and Kup :
		root.velocity.x = -MSPEED
		root.velocity.z = -MSPEED
	elif Kleft and Kdown:
		root.velocity.x = -MSPEED
		root.velocity.z = MSPEED

	elif Kleft:
		root.velocity.x = - MSPEED
		root.velocity.z = 0
	elif Kright and Kup:
		root.velocity.x = MSPEED
		root.velocity.z = -MSPEED
		
	elif Kright and Kdown:
		root.velocity.x = MSPEED

		root.velocity.z = MSPEED
		
	elif Kright:
		root.velocity.x = MSPEED
		root.velocity.z = 0
	elif Kup:
		root.velocity.z = -MSPEED
	elif Kdown:
		root.velocity.z = MSPEED
	
	if aftimagetimer > 0:
		aftimagetimer -= 1
	else:
		#var aft
		#aft = preload("res://OBJECT/GENERAL/Afterimage3D.tscn").instantiate()
		#aft.texture = root.sprite.sprite_frames.get_frame_texture(root.sprite.animation, root.sprite.frame)
		#aft.flip_h = root.sprite.flip_h
		#aft.global_position = root.sprite.global_position
		#
		#get_parent().add_child(aft)
		aftimagetimer = 2
	if Input.is_action_just_pressed("PAD1_A"):
		#root.hurbcol.disabled = false
		parent.change_state("DashAttack")
	if Input.is_action_just_released("PAD1_C"):
		#root.hurbcol.disabled = false
		parent.change_state("Idle")
	if (Input.is_action_just_pressed("PAD1_B") || root.velocity.y < 0) && root.is_on_floor():
		#root.hurbcol.disabled = false
		root.vecair = true
		parent.change_state("Jump")
	if parent.state_time >= 45:
		#root.hurbcol.disabled = false
		if root.is_on_floor():
			parent.change_state("Idle")
		else:
			parent.change_state("Fall")
	



func _step_frozen():
	super._step_frozen()


func _exit(next_state):
	root.MOVE_ENABLED = true
	root.GRAV_ENABLED = false
	super._exit(next_state)
