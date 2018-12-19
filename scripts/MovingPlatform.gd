extends Path2D

export var SPEED = 100

func _ready():
    assert(curve.get_point_count() == 2)

    var first_point = curve.get_point_position(0)
    var second_point = curve.get_point_position(1)
    var curve_length = curve.get_baked_length()

    # Animation is there and back, so we have to multiply it by 2
    var animation_length = curve_length * 2 / SPEED

    var movement_animation = Animation.new()
    movement_animation.length = animation_length
    movement_animation.loop = true

    var track_index = movement_animation.add_track(Animation.TYPE_VALUE)
    movement_animation.track_set_path(track_index, "Platform:position")
    movement_animation.track_insert_key(track_index, 0.0, first_point)
    movement_animation.track_insert_key(track_index, animation_length / 2, second_point)
    movement_animation.track_insert_key(track_index, animation_length, first_point)

    var animation_name = "movement"
    $AnimationPlayer.add_animation(animation_name, movement_animation)
    $AnimationPlayer.playback_speed = 1
    $AnimationPlayer.play(animation_name)
