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
    }
}
var current_level_id = null

func get_current_level():
    return levels[current_level_id]
