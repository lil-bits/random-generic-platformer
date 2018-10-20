# WorldComplete.gd
extends Area2D

export(String, FILE, "*.tscn") var target_world

func _physics_process(delta):
    for body in get_overlapping_bodies():
        if body.name == "Player":
            get_tree().change_scene(target_world)
