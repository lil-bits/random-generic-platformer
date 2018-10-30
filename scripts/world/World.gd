extends Node

func _ready():
    assert(has_node("Player"))
    assert(has_node("HUD"))

    for level in get_tree().get_nodes_in_group("world_levels"):
        level.connect("level_area_entered", self, "_on_level_area_entered")
        level.connect("level_area_exited", self, "_on_level_area_exited")

    if Game.current_level_id:
        $Player.position = get_node(Game.get_current_level().entrance_node).position
        Game.current_level_id = null


func _on_level_area_entered(level_id):
    $HUD.show_message(Game.levels[level_id].name)

func _on_level_area_exited():
    $HUD.clear_message()
