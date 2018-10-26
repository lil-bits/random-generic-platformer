extends KinematicBody2D

signal enemy_touched

const UP = Vector2(0.0, -1.0)

var motion = Vector2(200, 0)

func _ready():
    add_to_group("enemies")

func _physics_process(delta):
    for i in range(self.get_slide_count()):
        if self.get_slide_collision(i).collider.name == "Player":
            emit_signal("enemy_touched")

    if is_on_wall():
        motion.x = -motion.x

    move_and_slide(motion, UP)
