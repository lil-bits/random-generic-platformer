extends Control

func _on_StartGame_pressed():
    print("start game pressed")
    get_tree().change_scene("scenes/world/World.tscn")


func _on_QuitGame_pressed():
    print("quit game pressed")
    get_tree().quit()
