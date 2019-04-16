extends KinematicBody2D

const SPEED = 750
const GRAVITY = 3600
const UP = Vector2(0,-1)
const JUMP_SPEED = -1750

var motion = Vector2()
export var world_limit = 3000

func _ready():
	Global.Player = self

#Called during the physics processing step of the main loop.
#Physics processing means that the frame rate is synced
#to the physics, i.e. the delta variable should be constant.
func _physics_process(delta):
	update_motion(delta)
	
#Called during the processing step of the main loop. 
#Processing happens at every frame and as fast as possible,
#so the delta time since the previous frame is not constant.
func _process(delta):
	update_animation(motion)
	
func update_motion(delta):
	fall(delta)
	run()
	jump()
	move_and_slide(motion, UP)

func update_animation(motion):
	$AnimatedSprite.update(motion)

func fall(delta):
	if is_on_floor() or is_on_ceiling():
		motion.y = 0
	else:
		#Here we are using delta twice (rememeber move_and_slice 
		#already uses delta) in order to calculate de acceleation.
		#This is actualli GRAVITY * delta * delta
		motion.y += GRAVITY * delta
		
	if motion.y > world_limit:
		Global.GameState.end_game()
	
func run():
	if Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		motion.x = SPEED
	elif Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		motion.x = -SPEED
	else:
		motion.x = 0

func jump():
	if is_on_floor() and Input.is_action_pressed("ui_up"):
		motion.y = JUMP_SPEED

func hurt():
	motion.y = JUMP_SPEED