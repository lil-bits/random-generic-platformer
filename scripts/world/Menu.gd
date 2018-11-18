extends "res://scripts/GameMenu.gd"

func _ready():
    $Panel/ButtonContainer/ExitGameButton.connect(
        "pressed", self, "_exit_game_button_pressed")

func _exit_game_button_pressed():
    get_tree().quit()
