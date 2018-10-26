extends CanvasLayer

func _ready():
    update_values({"coins": 0})

func show_message(message):
    $Message.text = message
    $Message.show()

func show_start_level_message(message):
    show_message(message)
    yield(get_tree().create_timer(2.0), "timeout")
    $Message.hide()

func update_values(values):
    $Container/Label.text = "x{coins}".format({"coins": values.coins})
