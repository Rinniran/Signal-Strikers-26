extends Character




enum pardir
{
	HIGH,
	MID,
	LOW
}

const DASHSPEED: float = 5000.0
const JUMP_VELOCITY: float = -400.0
const GRAVITY: float = 200.0
var anim_can_resume_after_hitstop = false
var dashes: int = 2
var CAN_MOVE: bool = true
var testnum: int = 2
var IN_CUTSCENE: bool = false
var parry_direction = pardir.MID
var parrycool = 0
var paractfr = 0
var parrying = false
var conparries = 0
var iframes = 0
var vecair = false
var DAttacked = false
var isKilled = false


@export var hitstopnull = false
@export var Dsound:AudioStreamPlayer
@export var dc:AudioStreamPlayer

@onready var state = $StateMachine
@onready var hurb = $hurtbox
@onready var hurbcol = $hurtbox/CollisionShape2D

var dashcoy = 0

func _ready() -> void:
	super()
	state.initialize()

func _physics_process(delta: float) -> void:
	super(delta)
	#if (Global.p1health <= 0 || Global.time <= 0) && isKilled == false:
		#state.change_state("Die")
		#isKilled = true
	
	# Add the gravity.
	
	
	
	
	#for hazards in hurb.get_overlapping_areas():
		#if state.state_name != "Damage" && state.state_name != "Die" && state.state_name != "DashAttack" && state.state_name != "MountTank" && state.state_name != "LeaveTank":
			#if hazards.is_in_group("Enemy") || hazards.is_in_group("En_Attack"):
				#if !Global.invincibility:
					#damageHandle(1)
	#if conparries >= 5:
		#Global.p1health += 1
		#conparries = 0
	if is_on_floor():
		dashes = 2
	if IN_CUTSCENE == false:
		state.advance()
	#print_debug(velocity.x)
	#if parrycool > 0: 
		#parrycool -= 1
		#
	#if Input.is_action_just_pressed("PAD1_LEFT") || Input.is_action_just_pressed("PAD1_RIGHT") || Input.is_action_just_pressed("PAD1_UP") || Input.is_action_just_pressed("PAD1_DOWN"):
		#if parrycool <= 0:
			#parrying = true
		#parrycool = 20
	#
	#if iframes > 0:
		#hurbcol.disabled = true
		#iframes -= 1
	#else:
		#hurbcol.disabled = false
	#if sprite.animation == "Fjump":
		#if Global.hitstop == false:
			#if sprite.flip_h == true:
				#sprite.rotation_degrees -= 8
			#elif sprite.flip_h == false:
				#sprite.rotation_degrees += 8
	#else:
		#sprite.rotation_degrees = 0
	if parrying == true:
		paractfr += 1
		if Input.is_action_pressed("PAD1_LEFT") || Input.is_action_pressed("PAD1_RIGHT"):
			parry_direction = pardir.MID
		
		if Input.is_action_pressed("PAD1_DOWN"):
			parry_direction = pardir.LOW
		
		if Input.is_action_pressed("PAD1_UP"):
			parry_direction = pardir.HIGH
		if Input.is_action_pressed("PAD1_LEFT") || Input.is_action_pressed("PAD1_RIGHT") || Input.is_action_pressed("PAD1_UP") || Input.is_action_pressed("PAD1_DOWN"):
			if paractfr >= 10:
				parrying = false
		if paractfr >= 14:
			parrying = false
	else:
		paractfr = 0
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if vecair == true:
		vectorair(370)
	else:
		DAttacked = false
		
	state.advance()
	move_and_slide()
		
	
	
		
	
	if dashcoy > 0:
		dashcoy -= 1

func damageHandle(damage):
	var parriedhigh = false
	var parriedmid = false
	var parriedlow = false
	for hazards in $MPBox.get_overlapping_areas():
		if hazards.is_in_group("Enemy") || hazards.is_in_group("En_Attack"):
			if parry_direction == pardir.MID:
				
				parriedmid = true
	for hazards in $HPBox.get_overlapping_areas():
		if hazards.is_in_group("Enemy") || hazards.is_in_group("En_Attack"):
			if parry_direction == pardir.HIGH:
				parriedhigh = true
	for hazards in $LPBox.get_overlapping_areas():
		if hazards.is_in_group("Enemy") || hazards.is_in_group("En_Attack"):
			if parry_direction == pardir.LOW:
				parriedlow = true
	
	if (parriedhigh || parriedlow || parriedmid) && parrying:
		iframes = 40
		Global.hitstopframes = 12
		conparries += 1
		Global.hitstop = true
		#if is_on_floor():
			#sprite.play("parryground")
		#else:
			#sprite.play("parryair")
		parrycool = 0
		paractfr = 0
		parrying = false
		#var parryobj = preload("uid://ddlo8tdk0vpj0").instantiate()
		#parryobj.global_position = global_position
		#get_parent().add_child(parryobj)
		#var parryspark = preload("uid://o3cqd4kts4be").instantiate()
		#parryspark.global_position = global_position
		#get_parent().add_child(parryspark)
		Global.time += 5
		Global.chaintime = Global.chaintimereset
		
	else: 
		conparries = 0
		Global.chain = 0
		Global.p1health -= damage
		state.change_state("Damage")

func vectorair(ms):
	
	if velocity.x > ms:
		velocity.x = ms
	elif velocity.x < -ms:
		velocity.x = -ms
	#if state.state_name != "Damage" && state.state_name != "Die" && state.state_name != "DashAttack" && state.state_name != "Dash" && state.state_name != "Attack1":
		#if sprite.animation != "Fjump":
			#sprite.play("Fjump")
	if Input.is_action_pressed("PAD1_LEFT"):
		if velocity.x > 0:
			velocity.x -= 2 * 8
		else:
			velocity.x -= 9
	elif velocity.x < 0:
		velocity.x += 5 
	if Input.is_action_pressed("PAD1_RIGHT"):
		if velocity.x < 0:
			velocity.x += 2 * 8
	elif velocity.x > 0:
		velocity.x += 5 


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Tankenter"):
		state.change_state("MountTank")
