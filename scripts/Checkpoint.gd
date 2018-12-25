extends Node2D

signal checkpoint_reached(checkpoint)

func _ready():
    $SaveArea.connect("body_entered", self, "_on_body_entered")

func _on_body_entered(_body):
    emit_signal("checkpoint_reached", self)
