extends Control

func _on_StartGame_pressed():
    print("start game pressed")
    get_tree().change_scene("scenes/Level1.tscn")


func _on_QuitGame_pressed():
    print("quit game pressed")
    get_tree().quit()
