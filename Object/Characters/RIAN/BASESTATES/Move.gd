@tool
extends BaseState

var moverandomizer = RandomNumberGenerator.new()
var movechoice

func _enter(data = {}):
	super._enter(data)
	root.MOVE_ENABLED = true
	root.GRAV_ENABLED = true
	


func _step():
	super._step()
	if root.is_on_floor():# && !Global.hitstop && root.sprite.animation != "run"
			root.vecair = false
			#root.sprite.play("run")
	if root.velocity.x == 0:
		parent.change_state("Idle")
	

	if Input.is_action_just_pressed("Jump") || root.velocity.y > 0:
		parent.change_state("Jump")
	if root.velocity.y < 0:
		parent.change_state("Fall") 
	
	if Input.is_action_just_pressed("AttackA"):
		# if root.position.distance_to(Enemy.position) < 5:
		#parent.change_state("throw")
		#if Input.is_action_just_pressed("PAD1_UP"):
			#parent.change_state("Attackup_g")
		#elif Input.is_action_just_pressed("PAD1_DOWN"):
			#parent.change_state("Attackdown_g")
		#else:
		if root.dashcoy > 0:
			parent.change_state("DashAttack")
		else:
			parent.change_state("Attack1")
	
	if Input.is_action_just_pressed("Dash"):
		parent.change_state("Dash")
	
	
	



func _step_frozen():
	super._step_frozen()


func _exit(next_state):
	root.MOVE_ENABLED = true
	root.GRAV_ENABLED = false
	super._exit(next_state)
