extends Node

# Exponentially decay `source` to `target` over time. Framerate aware.
#
# `smoothness` is a floating point number clamped between 0 amd 1.
# It determines, what fraction of `source` still hasn't decayed towards
# `target` after 1 second. `smoothness` equal to 0 essentially means
# `source = target` while 1 means `source = source`
#
# `delta` is the standard GDScript `delta` time passed into `_process` or
# `_physics_process`
#
# Useful for per-frame updates of a value:
#     x = decay(x, 0, 0.001, delta)
#
# http://www.rorydriscoll.com/2016/03/07/frame-rate-independent-damping-using-lerp/
static func decay(source, target, smoothness, delta):
    return lerp(source, target, 1 - pow(clamp(smoothness, 0, 1), delta))
