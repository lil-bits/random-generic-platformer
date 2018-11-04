extends CanvasLayer

func show_message(message):
    $Message.text = message

func clear_message():
    $Message.text = ""

func update_values(values):
    $Container/Label.text = "x{coins}".format({"coins": values.coins})
