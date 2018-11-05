extends KinematicBody2D

const Math = preload("res://scripts/Math.gd")

const SPEED = 200
const DRAG_FACTOR = 0.0001

var motion = Vector2()

func _physics_process(delta):
    var go_left = Input.is_action_pressed("ui_left")
    var go_right = Input.is_action_pressed("ui_right")
    var go_up = Input.is_action_pressed("ui_up")
    var go_down = Input.is_action_pressed("ui_down")

    if go_left:
        motion.x = -SPEED

    if go_right:
        motion.x = SPEED

    if go_up:
        motion.y = -SPEED

    if go_down:
        motion.y = SPEED

    motion.x = Math.decay(motion.x, 0, DRAG_FACTOR, delta)
    motion.y = Math.decay(motion.y, 0, DRAG_FACTOR, delta)

    motion = move_and_slide(motion)
