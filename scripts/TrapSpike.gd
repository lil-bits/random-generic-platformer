extends Area2D

export var time_initial_delay = 0.0
export var time_disabled = 2.0
export var time_fadein = 0.5
export var time_enabled = 0.5

signal trap_triggered

enum TrapSpikeState {
    Disabled,
    Fadein,
    Enabled,
}

var _state = TrapSpikeState.Disabled

func _ready():
    add_to_group("traps")
    _start_trap_cycle()

func _physics_process(delta):
    if _state == TrapSpikeState.Enabled:
        for body in self.get_overlapping_bodies():
            if body.name == "Player":
                emit_signal("trap_triggered")

func _start_trap_cycle():
    var tree = get_tree()
    yield(tree.create_timer(time_initial_delay), "timeout")

    while true:
        match _state:
            TrapSpikeState.Disabled:
                yield(tree.create_timer(time_disabled), "timeout")
                _state = TrapSpikeState.Fadein
                $Sprite.modulate = Color(1, 1, 0, 1)
            TrapSpikeState.Fadein:
                yield(tree.create_timer(time_fadein), "timeout")
                _state = TrapSpikeState.Enabled
                $Sprite.modulate = Color(1, 0, 0, 1)
            TrapSpikeState.Enabled:
                yield(tree.create_timer(time_enabled), "timeout")
                _state = TrapSpikeState.Disabled
                $Sprite.modulate = Color(0, 1, 0, 1)
