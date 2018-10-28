extends Node

export(String) var id

var coins = 0

func _ready():
    assert(has_node("Player"))
    assert(has_node("HUD"))
    assert(Game.levels.has(id))

    for enemy in get_tree().get_nodes_in_group("enemies"):
        enemy.connect("enemy_touched", self, "_on_enemy_touched")

    for trap in get_tree().get_nodes_in_group("traps"):
        trap.connect("trap_triggered", self, "_on_trap_triggered")

    for coin in get_tree().get_nodes_in_group("coins"):
        coin.connect("coin_taken", self, "_increment_coins")

    $HUD.show_start_level_message(Game.levels[id].name)

func _on_trap_triggered():
    get_tree().change_scene("scenes/StartMenu.tscn")

func _on_enemy_touched():
    get_tree().change_scene("scenes/StartMenu.tscn")

func _increment_coins():
    coins += 1
    $HUD.update_values({"coins": coins})
