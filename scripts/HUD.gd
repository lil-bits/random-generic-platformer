extends CanvasLayer

func show_message(message):
    $Message.text = message
    $Message.show()

func show_start_level_message(message):
    show_message(message)
    yield(get_tree().create_timer(2.0), "timeout")
    $Message.hide()
