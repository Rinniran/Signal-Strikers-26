@tool
extends BaseState

var moverandomizer = RandomNumberGenerator.new()
var movechoice

func _enter(data = {}):
	super._enter(data)
	root.anim_can_resume_after_hitstop = true
	root.CAN_MOVE = false
	root.GRAV_ENABLED = false
	root.visible = false
	root.velocity.x = 0
	root.velocity.y = 0


func _step():
	super._step()
	
	
	
	



func _step_frozen():
	super._step_frozen()


func _exit(next_state):
	root.CAN_MOVE = false
	root.GRAV_ENABLED = true
	super._exit(next_state)


func _on_sprite_animation_finished() -> void:
	if root.sprite.animation == "WaitA":
		root.sprite.play("WaitB")
