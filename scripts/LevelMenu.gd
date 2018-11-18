extends "res://scripts/GameMenu.gd"

signal level_exited

func _ready():
    $Panel/ButtonContainer/ExitLevelButton.connect(
        "pressed", self, "_exit_level_button_pressed")

func _exit_level_button_pressed():
    _deactivate()
    emit_signal("level_exited")
