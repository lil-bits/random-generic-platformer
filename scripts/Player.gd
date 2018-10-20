extends KinematicBody2D

signal update_hud

const UP = Vector2(0.0, -1.0)
const GRAVITY = 20
const MAX_SPEED = 200
const ACCELERATION = 50
const JUMP_HEIGHT_LOW = -420
const JUMP_HEIGHT_HIGH = -550

var motion = Vector2()

func _process(delta):
    pass

func _physics_process(delta):
    motion.y += GRAVITY

    var go_left = Input.is_action_pressed("ui_left")
    var go_right = Input.is_action_pressed("ui_right")
    var jump_low = Input.is_action_just_pressed("ui_down")
    var jump_high = Input.is_action_just_pressed("ui_up")
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
        if jump_high:
            motion.y = JUMP_HEIGHT_HIGH
        elif jump_low:
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
