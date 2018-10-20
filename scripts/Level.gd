extends Node

export(String) var level_name

func _ready():
	if has_node("HUD"):
		$HUD.show_start_level_message(level_name)
