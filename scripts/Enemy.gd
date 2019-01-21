extends KinematicBody2D

signal enemy_touched

const UP = Vector2(0.0, -1.0)
const GRAVITY = 20
const SPEED = 100

var _direction = 1
var _motion = Vector2()

func _ready():
    add_to_group("enemies")

    $Area2D.connect("body_entered", self, "_on_body_entered")

func serialize():
    return {
        "file": get_filename(),
        "position": global_position,
    }

func deserialize(properties):
    global_position = properties.position

func _physics_process(_delta):
    if is_on_wall() or not $RayCast2D.is_colliding():
        _direction *= -1
        $RayCast2D.position.x *= -1

    _motion.y += GRAVITY
    _motion.x = SPEED * _direction

    _motion = move_and_slide(_motion, UP)

func _on_body_entered(_body):
    emit_signal("enemy_touched")
