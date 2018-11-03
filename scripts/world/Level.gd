extends Area2D

export(String) var level_id
export(Texture) var texture

signal level_area_entered
signal level_area_exited

var is_active = false

func _ready():
    assert(Game.levels.has(level_id))

    $Sprite.texture = texture

    connect("body_entered", self, "_on_area_entered")
    connect("body_exited", self, "_on_area_exited")

func _process(delta):
    if is_active:
        var enter_level = Input.is_action_pressed("ui_select")

        if enter_level:
            Game.current_level_id = level_id
            get_tree().change_scene(Game.get_current_level().scene)


func _on_area_entered(body):
    is_active = true

    emit_signal("level_area_entered", level_id)

func _on_area_exited(body):
    is_active = false

    emit_signal("level_area_exited")
