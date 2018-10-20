extends Node

signal update_hud

export(String) var level_name

var coins = 0

func _ready():
    assert(has_node("HUD"))

    $HUD.show_start_level_message(level_name)

    for coin in get_tree().get_nodes_in_group("coins"):
        coin.connect("coin_taken", self, "increment_coins")

func increment_coins():
    coins += 1
    emit_signal('update_hud', {"coins": coins})
