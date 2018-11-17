extends Area2D

signal level_finished

func _ready():
    self.connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
    emit_signal("level_finished")
