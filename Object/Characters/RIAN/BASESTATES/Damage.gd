@tool
extends BaseState

func _enter(data = {}):
	super._enter(data)
	root.vecair = false
	root.CAN_MOVE = false
	root.GRAV_ENABLED = true
	root.blood.emitting = true
	root.anim_can_resume_after_hitstop = true
	root.sprite.play("damage")
	root.velocity.y = 0
	root.velocity.y -= 300
	if root.sprite.flip_h == false:
		root.velocity.x = -88
	if root.sprite.flip_h == true:
		root.velocity.x = 88


func _step():
	super._step()
	
	if root.is_on_floor() && parent.state_time >= 10:
		root.iframes = 30
		parent.change_state("Idle")
	
	



func _step_frozen():
	super._step_frozen()


func _exit(next_state):
	root.CAN_MOVE = true
	root.GRAV_ENABLED = false
	super._exit(next_state)
