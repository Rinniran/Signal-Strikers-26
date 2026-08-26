@tool
extends BaseState

var moverandomizer = RandomNumberGenerator.new()
var movechoice
var aftimagetimer = 2
var MSPEED = 380



func _enter(data = {}):
	super._enter(data)
	root.anim_can_resume_after_hitstop = true
	if not root.is_on_floor():
		root.dashes -= 1
	SoundEngine.playsoundstring(0,"res://AUDIO/SE/DashFin.ogg",-2)
	root.sprite.play("dash")
	root.GRAV_ENABLED = false
	root.CAN_MOVE = false
	root.velocity.y = 0
	


func _step():
	super._step()
	var Kup = Input.is_action_pressed("PAD1_UP")
	var Kdown = Input.is_action_pressed("PAD1_DOWN")
	var Kleft = Input.is_action_pressed("PAD1_LEFT")
	var Kright = Input.is_action_pressed("PAD1_RIGHT")
	var rspr = root.sprite
	
	root.hurbcol.disabled = true
	
	
	
	if Kleft and Kup :
		rspr.flip_h = true
		root.velocity.x = -MSPEED
		root.velocity.y = -MSPEED
		rspr.play("ADUpDiag")
	elif Kleft and Kdown and !root.is_on_floor():
		rspr.flip_h = true
		root.velocity.x = -MSPEED
		root.velocity.y = MSPEED
		if root.is_on_floor():
			rspr.play("dash")
		else:
			rspr.play("ADDownDiag")
	elif Kleft:
		rspr.flip_h = true
		rspr.flip_h = true
		if root.is_on_floor():
			rspr.play("dash")
		else:
			rspr.play("ADSide")
		root.velocity.x = - MSPEED
		root.velocity.y = 0
	elif Kright and Kup:
		rspr.flip_h = false
		
		rspr.play("ADUpDiag")
		root.velocity.x = MSPEED
		root.velocity.y = -MSPEED
		
	elif Kright and Kdown and !root.is_on_floor():
		rspr.flip_h = false
		root.velocity.x = MSPEED
		if root.is_on_floor():
			rspr.play("dash")
		else:
			rspr.play("ADDownDiag")
		root.velocity.y = MSPEED
		
	elif Kright:
		rspr.flip_h = false
		root.velocity.x = MSPEED
		root.velocity.y = 0
		if root.is_on_floor():
			rspr.play("dash")
		else:
			rspr.play("ADSide")
	elif Kup:
		root.velocity.y = -MSPEED
		rspr.play("ADUp")
	elif Kdown and !root.is_on_floor():
		root.velocity.y = MSPEED
		rspr.play("ADDown")
	else:
		parent.change_state("Idle")
	
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
		aft.global_position = root.sprite.global_position
		
		get_parent().add_child(aft)
		aftimagetimer = 2
	if Input.is_action_just_pressed("PAD1_A"):
		root.hurbcol.disabled = false
		
		parent.change_state("DashAttack")
		
	if Input.is_action_just_released("PAD1_C"):
		root.hurbcol.disabled = false
		
		parent.change_state("Idle")
	if (Input.is_action_just_pressed("PAD1_B") || root.velocity.y < 0) && root.is_on_floor():
		root.hurbcol.disabled = false
		root.vecair = true
		
		parent.change_state("Jump")
	if parent.state_time >= 45:
		root.hurbcol.disabled = false
		root.dashcoy = 15
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
