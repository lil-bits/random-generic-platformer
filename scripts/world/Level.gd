extends Area2D

export(String) var level_id
export(Texture) var texture

signal level_area_entered
signal level_area_exited

func _ready():
    assert(Game.levels.has(level_id))

    $Sprite.texture = texture

    connect("body_entered", self, "_on_area_entered")
    connect("body_exited", self, "_on_area_exited")

func _on_area_entered(body):
    emit_signal("level_area_entered", level_id)

func _on_area_exited(body):
    emit_signal("level_area_exited")
