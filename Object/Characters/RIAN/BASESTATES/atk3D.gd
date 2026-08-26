@tool
extends BaseState

var moverandomizer = RandomNumberGenerator.new()
var movechoice
var didbox = false
var didpj = false
func _enter(data = {}):
	super._enter(data)
	root.CAN_MOVE = true
	root.GRAV_ENABLED = true
	if root.vecair == true:
		root.vecair = true
	root.anim_can_resume_after_hitstop = false
	root.sprite.play("attackg_a")


func _step():
	super._step()
	if !Global.hitstop:
		if root.sprite.is_playing() == false:
			root.sprite.play()
		
	if root.is_on_floor() && !Global.hitstop && root.sprite.animation != "attackg_a":
			root.sprite.play("attackg_a")
	
	if parent.state_time > 5:
		if root.is_on_floor():
			root.vecair = false
	
	if root.sprite.frame >= 4:
		if root.is_on_floor():
			parent.change_state("Idle")
		else:
			parent.change_state("Fall")
	if root.sprite.frame >= 3:
		
		if Input.is_action_just_pressed("PAD1_C"):
			parent.change_state("Dash")
		if Input.is_action_just_pressed("PAD1_A"):
			root.sprite.stop()
			root.sprite.frame = 0
			root.sprite.play("attackg_a")
		if Input.is_action_just_pressed("PAD1_B") && root.is_on_floor():
			parent.change_state("Jump")
	
	if root.sprite.frame == 3:
		if didbox == false:
			var hitbox = preload("uid://dahio5ccpil3v").instantiate()
			hitbox.position = root.position
			hitbox.own = root
			get_parent().add_child(hitbox)
			didbox = true
		
		if didpj == false:
			var pj = preload("uid://dwny00npp0uri").instantiate()
			pj.position = root.position
			pj.own = root
			if root.sprite.flip_h == false:
				pj.direction.x = 1
			else:
				pj.direction.x = -1
			get_parent().add_child(pj)
			didpj = true
	else:
		didbox = false
		didpj = false
	
	
	



func _step_frozen():
	super._step_frozen()


func _exit(next_state):
	root.CAN_MOVE = true
	root.GRAV_ENABLED = false
	super._exit(next_state)


func _on_sprite_animation_finished() -> void:
	if root.sprite.animation == "attackg_a":
		if root.is_on_floor():
			parent.change_state("Idle")
		else:
			parent.change_state("Fall")
