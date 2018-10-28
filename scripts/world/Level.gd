extends Area2D

export(String) var level_id
export(Texture) var texture

signal level_area_entered
signal level_area_exited

var active_level = null

func _ready():
    assert(Game.levels.has(level_id))

    $Sprite.texture = texture

    connect("body_entered", self, "_on_area_entered")
    connect("body_exited", self, "_on_area_exited")

func _process(delta):
    if active_level:
        var enter_level = Input.is_action_pressed("ui_select")

        if enter_level:
            Game.current_level = active_level
            get_tree().change_scene(active_level.scene)


func _on_area_entered(body):
    var level = Game.levels[level_id]
    active_level = level

    emit_signal("level_area_entered", level.name)

func _on_area_exited(body):
    active_level = null

    emit_signal("level_area_exited")
