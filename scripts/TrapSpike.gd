extends Area2D

export var time_initial_delay = 0.0
export var time_disabled = 2.0
export var time_fade_in = 0.5
export var time_enabled = 0.5

signal enemy_touched

enum TrapSpikeState {
    Disabled,
    FadeIn,
    Enabled,
}

var _state = TrapSpikeState.Disabled

func _ready():
    add_to_group("enemies")

    if time_initial_delay == 0.0:
        _on_Timer_timeout()
    else:
        _restart_timer_with(time_initial_delay)

func serialize():
    return {
        "file": get_filename(),
        "position": global_position,
        "time_initial_delay": time_initial_delay,
        "time_disabled": time_disabled,
        "time_fade_in": time_fade_in,
        "time_enabled": time_enabled,
    }

func deserialize(properties):
    global_position = properties.position
    time_initial_delay = properties.time_initial_delay
    time_disabled = properties.time_disabled
    time_fade_in = properties.time_fade_in
    time_enabled = properties.time_enabled

func _physics_process(_delta):
    if _state == TrapSpikeState.Enabled:
        for body in self.get_overlapping_bodies():
            emit_signal("enemy_touched")

func _go_to_enabled():
    _restart_timer_with(time_enabled)
    _state = TrapSpikeState.Enabled
    $Sprite.modulate = Color(1, 0, 0, 1)

func _go_to_disabled():
    _restart_timer_with(time_disabled)
    _state = TrapSpikeState.Disabled
    $Sprite.modulate = Color(0, 1, 0, 1)

func _go_to_fade_in():
    _restart_timer_with(time_fade_in)
    _state = TrapSpikeState.FadeIn
    $Sprite.modulate = Color(1, 1, 0, 1)

func _restart_timer_with(time):
    assert(time > 0) # Timer requires wait time to be > 0
    $Timer.set_wait_time(time)
    $Timer.start()

func _on_Timer_timeout():
    match _state:
        TrapSpikeState.Disabled:
            _go_to_fade_in()
        TrapSpikeState.FadeIn:
            _go_to_enabled()
        TrapSpikeState.Enabled:
            _go_to_disabled()
