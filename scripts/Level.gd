extends Node

export(String) var level_name

signal start_level

func _ready():
	if has_node("HUD"):
		$HUD.show_start_level_message(level_name)
