extends KinematicBody2D

const UP = Vector2(0.0, -1.0)

var motion = Vector2(200, 0)

func _physics_process(delta):
	for body in $Area2D.get_overlapping_bodies():
		if body.name == "Player":
			get_tree().change_scene("scenes/StartMenu.tscn")
	
	if is_on_wall():
		motion.x = -motion.x
	move_and_slide(motion, UP)
	