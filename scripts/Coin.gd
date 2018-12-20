extends Area2D

signal coin_taken

func _ready():
    self.connect("body_entered", self, "_on_body_entered")

func _on_body_entered(_body):
    _take_coin()

func _take_coin():
    emit_signal("coin_taken")
    self.queue_free()
