extends Area2D

export(String) var level_id
export(Texture) var texture

signal level_area_entered
signal level_area_exited

var active_level_id = null

func _ready():
    assert(Game.levels.has(level_id))

    $Sprite.texture = texture

    connect("body_entered", self, "_on_area_entered")
    connect("body_exited", self, "_on_area_exited")

func _process(delta):
    if active_level_id:
        var enter_level = Input.is_action_pressed("ui_select")

        if enter_level:
            Game.current_level_id = active_level_id
            get_tree().change_scene(Game.get_current_level().scene)


func _on_area_entered(body):
    active_level_id = level_id

    emit_signal("level_area_entered", active_level_id)

func _on_area_exited(body):
    active_level_id = null

    emit_signal("level_area_exited")
