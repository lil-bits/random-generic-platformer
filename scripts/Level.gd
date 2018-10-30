extends Node

var coins = 0

func _ready():
    assert(has_node("Player"))
    assert(has_node("HUD"))
    assert(has_node("LevelExit"))

    for enemy in get_tree().get_nodes_in_group("enemies"):
        enemy.connect("enemy_touched", self, "_on_enemy_touched")

    for trap in get_tree().get_nodes_in_group("traps"):
        trap.connect("trap_triggered", self, "_on_trap_triggered")

    for coin in get_tree().get_nodes_in_group("coins"):
        coin.connect("coin_taken", self, "_increment_coins")

    $HUD.show_start_level_message(Game.get_current_level().name)

func _on_trap_triggered():
    get_tree().change_scene("res://scenes/StartMenu.tscn")

func _on_enemy_touched():
    get_tree().change_scene("res://scenes/StartMenu.tscn")

func _increment_coins():
    coins += 1
    $HUD.update_values({"coins": coins})
