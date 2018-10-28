extends KinematicBody2D

const SPEED = 200

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

    motion.x = lerp(motion.x, 0, 0.2)
    motion.y = lerp(motion.y, 0, 0.2)

    motion = move_and_slide(motion)
