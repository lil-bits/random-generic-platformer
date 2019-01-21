extends KinematicBody2D

const Math = preload("res://scripts/Math.gd")

const UP = Vector2(0.0, -1.0)
const GRAVITY = 20
const MAX_SPEED = 150
const ACCELERATION = 20
const JUMP_HEIGHT_LOW = -250
const JUMP_HEIGHT_HIGH = -300
const DRAG_FACTOR_LAND = 0.0001
const DRAG_FACTOR_AIR = 0.1
const SNAP_TO_FLOOR = Vector2(0, 4)
const NO_SNAP = Vector2(0, 0)

var alive = true
var _motion = Vector2()
var _apply_drag = false
var _jumping = false

func _process(_delta):
    if _apply_drag or _motion.x == 0:
        $AnimatedSprite.play("Idle")
    elif _motion.x > 0:
        $AnimatedSprite.flip_h = false
        $AnimatedSprite.play("Run")
    elif _motion.x < 0:
        $AnimatedSprite.flip_h = true
        $AnimatedSprite.play("Run")

    if not is_on_floor():
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

    var snap = SNAP_TO_FLOOR

    if _jumping:
        snap = NO_SNAP

    _motion = move_and_slide_with_snap(_motion, snap, UP)

func die():
    alive = false
    _motion = Vector2(0, 0)
    $CollisionShape2D.disabled = true
    $AnimatedSprite.rotation_degrees = 90
    set_physics_process(false)

func live():
    alive = true
    $CollisionShape2D.disabled = false
    $AnimatedSprite.rotation_degrees = 0
    set_physics_process(true)
