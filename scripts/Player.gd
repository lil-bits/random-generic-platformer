extends KinematicBody2D

const UP = Vector2(0.0, -1.0)
const GRAVITY = 20
const MAX_SPEED = 200
const ACCELERATION = 50
const JUMP_HEIGHT_LOW = -420
const JUMP_HEIGHT_HIGH = -550


var motion = Vector2()
var score = 0
var health = 5

func _ready():
	pass
	
func _process(delta):
	pass

func _physics_process(delta):
	motion.y += GRAVITY
	
	var go_up_high = Input.is_key_pressed(KEY_W) or Input.is_action_pressed("ui_up")
	var go_up_low = Input.is_key_pressed(KEY_S) or Input.is_action_pressed("ui_down")
	var go_left = Input.is_key_pressed(KEY_A) or Input.is_action_pressed("ui_left")
	var go_right = Input.is_key_pressed(KEY_D) or Input.is_action_pressed("ui_right")
	var is_idle = not go_left and not go_right
	var apply_friction = is_idle
	
	if go_right:
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("Run")
	elif go_left:
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("Run")
	elif is_idle:
		$AnimatedSprite.play("Idle")
		
	if is_on_floor():
		if go_up_high:
			motion.y = JUMP_HEIGHT_HIGH
		elif go_up_low:
			motion.y = JUMP_HEIGHT_LOW
		if apply_friction:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if motion.y < 0:
			$AnimatedSprite.play("Jump")
		else:
			$AnimatedSprite.play("Fall")
		if apply_friction:
			motion.x = lerp(motion.x, 0, 0.05)
	
	motion = move_and_slide(motion, UP)
