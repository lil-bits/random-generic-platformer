extends KinematicBody2D

signal enemy_touched

const UP = Vector2(0.0, -1.0)
const GRAVITY = 20
const SPEED = 200

var _direction = 1
var _motion = Vector2()

func _ready():
    add_to_group("enemies")

func _physics_process(delta):
    if is_on_wall() or not $RayCast2D.is_colliding():
        _direction *= -1
        $RayCast2D.position.x *= -1

    _motion.y += GRAVITY
    _motion.x = SPEED * _direction

    for i in range(self.get_slide_count()):
        if self.get_slide_collision(i).collider.name == "Player":
            emit_signal("enemy_touched")

    _motion = move_and_slide(_motion, UP)
