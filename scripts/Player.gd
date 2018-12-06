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

var _motion = Vector2()
var _apply_drag = false
var _jumping = false

func _process(delta):
    if _apply_drag or _motion.x == 0:
        $AnimatedSprite.play("Idle")
    elif _motion.x > 0:
        $AnimatedSprite.flip_h = false
        $AnimatedSprite.play("Run")
    elif _motion.x < 0:
        $AnimatedSprite.flip_h = true
        $AnimatedSprite.play("Run")

    if _motion.y < 0:
        $AnimatedSprite.play("Jump")
    elif _motion.y > 0:
        $AnimatedSprite.play("Fall")

func _physics_process(delta):
    _motion.y += GRAVITY

    var go_left = Input.is_action_pressed("ui_left")
    var go_right = Input.is_action_pressed("ui_right")
    var jump_low = Input.is_action_just_pressed("ui_down")
    var jump_high = Input.is_action_just_pressed("ui_up")
    var is_idle = not go_left and not go_right
    _apply_drag = is_idle

    if go_right:
        _motion.x = min(_motion.x + ACCELERATION, MAX_SPEED)
    elif go_left:
        _motion.x = max(_motion.x - ACCELERATION, -MAX_SPEED)

    if is_on_floor():
        if jump_high:
            _motion.y = JUMP_HEIGHT_HIGH
            _jumping = true
        elif jump_low:
            _motion.y = JUMP_HEIGHT_LOW
            _jumping = true

        if _apply_drag:
            _motion.x = Math.decay(_motion.x, 0, DRAG_FACTOR_LAND, delta)
    else:
        if _apply_drag:
            _motion.x = Math.decay(_motion.x, 0, DRAG_FACTOR_AIR, delta)

    if _jumping and _motion.y > 0:
        _jumping = false

    var snap = Vector2(0, 32)

    if _jumping:
        snap = Vector2(0, 0)

    _motion = move_and_slide_with_snap(_motion, snap, UP)
