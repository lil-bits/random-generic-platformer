extends Node2D

signal spawned(instance)

export var spawn_delay = 3

onready var Fireball = preload("res://scenes/Fireball.tscn")

func _ready():
    add_to_group("spawners")

    $Timer.connect("timeout", self, "_fire")

    $Timer.wait_time = spawn_delay
    $Timer.start()


func _fire():
    var fireball = Fireball.instance()
    $SpawnPoint.add_child(fireball)

    emit_signal("spawned", fireball)

    $Timer.start()
