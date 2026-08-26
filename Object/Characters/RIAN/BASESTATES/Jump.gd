@tool
extends BaseState

func _enter(data = {}):
	super._enter(data)
	root.MOVE_ENABLED = true
	root.GRAV_ENABLED = true
	#root.sprite.play("jump")
	SoundEngine.playsoundstring(0, "uid://df0u16rdk18q3", -8)
	root.velocity.y -= root.chardata.jumpspeed



func _step():
	super._step()
	
	if root.is_on_floor() && parent.state_time >= 10:
		if root.velocity.x != 0:
			parent.change_state("Move")
		else:
			parent.change_state("Idle")
	
	if Input.is_action_just_released("PAD1_B"):
		root.velocity.y = 0
	if root.velocity.y > 0:
		parent.change_state("Fall")
	 
	if Input.is_action_just_pressed("PAD1_A"):
		# if root.position.distance_to(Enemy.position) < 5:
		#parent.change_state("throw")
		#if Input.is_action_just_pressed("PAD1_UP"):
			#parent.change_state("Attackup_g")
		#elif Input.is_action_just_pressed("PAD1_DOWN"):
			#parent.change_state("Attackdown_g")
		#else:
		if root.vecair:
			if root.DAttacked == false:
				parent.change_state("DashAttack")
		else:
			if root.dashcoy > 0:
				parent.change_state("DashAttack")
			else:
				parent.change_state("Attack1")
	
	if Input.is_action_just_pressed("PAD1_C") && root.dashes > 0:
		parent.change_state("Dash")
	
	
	



func _step_frozen():
	super._step_frozen()


func _exit(next_state):
	root.MOVE_ENABLED = true
	root.GRAV_ENABLED = false
	super._exit(next_state)
