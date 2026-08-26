@tool
extends BaseState

var moverandomizer = RandomNumberGenerator.new()
var movechoice
var aftimagetimer = 2
var MSPEED = 380


func _enter(data = {}):
	super._enter(data)
	root.hurbcol.disabled = true
	if not root.is_on_floor():
		root.dashes -= 1
	root.DAttacked = true
	root.anim_can_resume_after_hitstop = true
	root.sprite.play("attackair")
	root.GRAV_ENABLED = false
	root.CAN_MOVE = false
	root.velocity.y = 0
	var pj = preload("uid://dmhq1stc35g8v").instantiate()
	pj.position = root.position
	pj.own = root
	get_parent().add_child(pj)



func _step():
	super._step()
	var Kup = Input.is_action_pressed("PAD1_UP")
	var Kdown = Input.is_action_pressed("PAD1_DOWN")
	var Kleft = Input.is_action_pressed("PAD1_LEFT")
	var Kright = Input.is_action_pressed("PAD1_RIGHT")
	var rspr = root.sprite
	
	
	if Kleft and Kup :
		rspr.flip_h = true
		root.velocity.x = -MSPEED
		root.velocity.y = -MSPEED
	elif Kleft and Kdown:
		rspr.flip_h = true
		root.velocity.x = -MSPEED
		root.velocity.y = MSPEED

	elif Kleft:
		rspr.flip_h = true
		rspr.flip_h = true
		root.velocity.x = - MSPEED
		root.velocity.y = 0
	elif Kright and Kup:
		rspr.flip_h = false
		root.velocity.x = MSPEED
		root.velocity.y = -MSPEED
		
	elif Kright and Kdown:
		rspr.flip_h = false
		root.velocity.x = MSPEED

		root.velocity.y = MSPEED
		
	elif Kright:
		rspr.flip_h = false
		root.velocity.x = MSPEED
		root.velocity.y = 0
	elif Kup:
		root.velocity.y = -MSPEED
	elif Kdown:
		root.velocity.y = MSPEED


	
	
	if aftimagetimer > 0:
		aftimagetimer -= 1
	else:
		var aft
		if root.is_3d:
			aft = preload("res://OBJECT/GENERAL/Afterimage3D.tscn").instantiate()
		else:
			aft = preload("res://OBJECT/GENERAL/Afterimage.tscn").instantiate()
			aft.z_index = root.sprite.z_index - 1 
		aft.texture = root.sprite.sprite_frames.get_frame_texture(root.sprite.animation, root.sprite.frame)
		aft.flip_h = root.sprite.flip_h
		aft.global_position.x = root.sprite.global_position.x
		aft.global_position.y = root.sprite.global_position.y
		
		get_parent().add_child(aft)
		aftimagetimer = 2
	if (Input.is_action_just_pressed("PAD1_B") || root.velocity.y < 0) && root.is_on_floor():
		root.hurbcol.disabled = false
		parent.change_state("Jump")
	if parent.state_time >= 25:
		root.hurbcol.disabled = false
		if root.is_on_floor():
			parent.change_state("Idle")
		else:
			parent.change_state("Fall")
	



func _step_frozen():
	super._step_frozen()


func _exit(next_state):
	root.CAN_MOVE = true
	root.GRAV_ENABLED = false
	super._exit(next_state)
