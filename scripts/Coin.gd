extends Area2D

signal coin_taken

func _ready():
    self.connect("body_entered", self, "body_overlapped")

func body_overlapped(body):
    if body.name == "Player":
        emit_signal("coin_taken")
        self.queue_free()
