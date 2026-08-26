@tool
extends BaseState

var moverandomizer = RandomNumberGenerator.new()
var movechoice

func _enter(data = {}):
	super._enter(data)
	root.anim_can_resume_after_hitstop = false
	root.CAN_MOVE = false
	root.GRAV_ENABLED = false
	Global.musicP.stop()
	root.sprite.play("die")
	root.Dsound.play()
	root.damit.play()
	root.hurbcol.disabled = true


func _step():
	super._step()
	root.velocity.x = 0
	root.velocity.y = 0
	match(parent.state_time):
		3:
			root.sprite.offset = Vector2(1,0)
		6:
			root.sprite.offset = Vector2(-1,1)
		9:
			root.sprite.offset = Vector2(1,-1)
		12:
			root.sprite.offset = Vector2(0,0)
		14:
			root.sprite.offset = Vector2(1,0)
		16:
			root.sprite.offset = Vector2(-1,-1)
		18:
			root.sprite.offset = Vector2(1,1)
		20:
			root.sprite.offset = Vector2(0,0)
		120:
			root.white.visible = true
		122:
			root.black.visible = true
			root.dc.play()
			root.aah.play()
		360:
			get_tree().change_scene_to_file("res://SCENE/GAMEOVER.tscn")
	
	



func _step_frozen():
	super._step_frozen()


func _exit(next_state):
	root.CAN_MOVE = true
	root.GRAV_ENABLED = false
	super._exit(next_state)
