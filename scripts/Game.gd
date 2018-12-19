extends Node

var levels = {
    "1-1": {
        "scene": "res://scenes/Level1.tscn",
        "entrance_node": "/root/World/Levels/1-1",
        "name": "First level",
    },
    "1-2": {
        "scene": "res://scenes/Level2.tscn",
        "entrance_node": "/root/World/Levels/1-2",
        "name": "Second level",
    },
    "1-3": {
        "scene": "res://scenes/Level3.tscn",
        "entrance_node": "/root/World/Levels/1-3",
        "name": "Platform level",
    },
}
var current_level_id = null

func get_current_level():
    return levels[current_level_id]

var save_slots = [
    {
        'levels': {}
    }
]
var current_save_slot_id = 0

func save_level_progress(level_id, coins):
    var current_save_slot = save_slots[current_save_slot_id]

    if current_save_slot.levels.has(Game.current_level_id):
        if coins > current_save_slot.levels[Game.current_level_id].coins:
            current_save_slot.levels[Game.current_level_id].coins = coins
    else:
        current_save_slot.levels[Game.current_level_id] = {
            "coins": coins
        }

func count_coins_in_save_slot(id):
    var total_coins = 0

    for level_progress in save_slots[id].levels.values():
        total_coins += level_progress.coins

    return total_coins

func count_coins_in_current_save_slot():
    return count_coins_in_save_slot(current_save_slot_id)

func is_level_completed(id):
    return id in save_slots[current_save_slot_id].levels

func coins_in_level(id):
    assert(id in save_slots[current_save_slot_id].levels)

    return save_slots[current_save_slot_id].levels[id].coins
