extends Node

export(String) var level_name

var coins = 0

func _ready():
    assert(has_node("HUD"))

    $HUD.show_start_level_message(level_name)

    for coin in get_tree().get_nodes_in_group("coins"):
        coin.connect("coin_taken", self, "_increment_coins")

func _increment_coins():
    coins += 1
    $HUD.update_values({"coins": coins})
