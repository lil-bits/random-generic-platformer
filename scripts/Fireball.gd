extends Node2D

signal enemy_touched

var speed = 100

func _ready():
    add_to_group("enemies")

    $TerrainCollisionArea.connect("body_entered", self, "_on_terrain_body_entered")
    $PlayerCollisionArea.connect("body_entered", self, "_on_player_body_entered")

func _physics_process(delta):
    if not $TerrainCollisionArea/RayCast2D.is_colliding():
        $TerrainCollisionArea.monitoring = true

    position.x -= speed * delta

func _on_terrain_body_entered(_body):
    queue_free()

func _on_player_body_entered(_body):
    emit_signal("enemy_touched")

    queue_free()
