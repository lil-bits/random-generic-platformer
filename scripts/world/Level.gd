extends Area2D

export(String) var level_id
export(Texture) var texture

signal level_area_entered
signal level_area_exited

func _ready():
    assert(Game.levels.has(level_id))

    $Sprite.texture = texture

    if Game.is_level_completed(level_id):
        $Completed/CoinCount.text = "x{coins}".format({
            "coins": Game.coins_in_level(level_id)
        })
        $Completed.show()

    connect("body_entered", self, "_on_area_entered")
    connect("body_exited", self, "_on_area_exited")

func _on_area_entered(_body):
    emit_signal("level_area_entered", level_id)

func _on_area_exited(_body):
    emit_signal("level_area_exited")
