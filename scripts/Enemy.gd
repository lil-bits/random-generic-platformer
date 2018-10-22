extends KinematicBody2D

const UP = Vector2(0.0, -1.0)

var motion = Vector2(200, 0)

func _physics_process(delta):
    for i in range(self.get_slide_count()):
        if self.get_slide_collision(i).collider.name == "Player":
            get_tree().change_scene("scenes/StartMenu.tscn")

    if is_on_wall():
        motion.x = -motion.x

    move_and_slide(motion, UP)
