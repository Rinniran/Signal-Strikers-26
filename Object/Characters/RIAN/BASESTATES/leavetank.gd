@tool
extends BaseState

var moverandomizer = RandomNumberGenerator.new()
var movechoice

func _enter(data = {}):
	super._enter(data)
	root.anim_can_resume_after_hitstop = true
	root.CAN_MOVE = false
	root.GRAV_ENABLED = true
	root.visible = true
	
	root.position.y -= 48
	root.velocity.y = 0
	root.velocity.x = 0
	root.velocity.y = root.JUMP_VELOCITY
	root.sprite.play("BJump")


func _step():
	super._step()
	root.velocity.x = -80
	if root.is_on_floor():
		parent.change_state("Idle")
	
	
	



func _step_frozen():
	super._step_frozen()


func _exit(next_state):
	root.CAN_MOVE = true
	root.GRAV_ENABLED = false
	super._exit(next_state)


func _on_sprite_animation_finished() -> void:
	if root.sprite.animation == "WaitA":
		root.sprite.play("WaitB")
