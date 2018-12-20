extends CanvasLayer

signal menu_activated
signal menu_deactivated

var _active = false

func _ready():
    $Panel/ButtonContainer/ResumeButton.connect(
        "pressed", self, "_resume_button_pressed")

func _input(_event):
    if (Input.is_action_just_pressed("ui_cancel")):
        if _active:
            _deactivate()
        else:
            _activate()

func _resume_button_pressed():
    _deactivate()

func _activate():
    _active = true
    $Panel.show()

    emit_signal("menu_activated")

func _deactivate():
    _active = false
    $Panel.hide()

    emit_signal("menu_deactivated")
