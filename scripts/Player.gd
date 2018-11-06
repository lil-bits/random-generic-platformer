extends KinematicBody2D

const Math = preload("res://scripts/Math.gd")

const UP = Vector2(0.0, -1.0)
const GRAVITY = 20
const MAX_SPEED = 200
const ACCELERATION = 50
const JUMP_HEIGHT_LOW = -420
const JUMP_HEIGHT_HIGH = -550
const DRAG_FACTOR_LAND = 0.0001
const DRAG_FACTOR_AIR = 0.1

var motion = Vector2()
var _apply_drag = false

func _process(delta):
    if _apply_drag or motion.x == 0:
        $AnimatedSprite.play("Idle")
    elif motion.x > 0:
        $AnimatedSprite.flip_h = false
        $AnimatedSprite.play("Run")
    elif motion.x < 0:
        $AnimatedSprite.flip_h = true
        $AnimatedSprite.play("Run")

    if motion.y < 0:
        $AnimatedSprite.play("Jump")
    elif motion.y > 0:
        $AnimatedSprite.play("Fall")

func _physics_process(delta):
    motion.y += GRAVITY

    var go_left = Input.is_action_pressed("ui_left")
    var go_right = Input.is_action_pressed("ui_right")
    var jump_low = Input.is_action_just_pressed("ui_down")
    var jump_high = Input.is_action_just_pressed("ui_up")
    var is_idle = not go_left and not go_right
    _apply_drag = is_idle

    if go_right:
        motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
    elif go_left:
        motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)

    if is_on_floor():
        if jump_high:
            motion.y = JUMP_HEIGHT_HIGH
        elif jump_low:
            motion.y = JUMP_HEIGHT_LOW
        if _apply_drag:
            motion.x = Math.decay(motion.x, 0, DRAG_FACTOR_LAND, delta)
    else:
        if _apply_drag:
            motion.x = Math.decay(motion.x, 0, DRAG_FACTOR_AIR, delta)

    motion = move_and_slide(motion, UP)
