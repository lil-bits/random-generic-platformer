extends Node

var active_level = null

func _ready():
    assert(has_node("Player"))
    assert(has_node("HUD"))

    for level in get_tree().get_nodes_in_group("world_levels"):
        level.connect("level_area_entered", self, "_on_level_area_entered")
        level.connect("level_area_exited", self, "_on_level_area_exited")

    $WorldMenu.connect("menu_activated", self, "_on_menu_activated")
    $WorldMenu.connect("menu_deactivated", self, "_on_menu_deactivated")

    # If level id is set, it means player just left a level. She's put to given
    # level's position and level id is cleared (mostly for debugging purposes).
    if Game.current_level_id:
        $Player.position = get_node(Game.get_current_level().entrance_node).position
        Game.current_level_id = null

    $HUD.update_values({ "coins": Game.count_coins_in_current_save_slot() })

func _process(delta):
    if active_level:
        var enter_level = Input.is_action_just_pressed("ui_select")

        if enter_level:
            Game.current_level_id = active_level
            get_tree().change_scene(Game.get_current_level().scene)

func _on_level_area_entered(level_id):
    active_level = level_id

    $HUD.show_message(Game.levels[level_id].name)

func _on_level_area_exited():
    active_level = null

    $HUD.clear_message()

func _on_menu_activated():
    get_tree().paused = true

func _on_menu_deactivated():
    get_tree().paused = false
