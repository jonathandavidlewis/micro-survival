class_name HorizontalFlipper
extends Node2D

@export var translation_base: Node2D

@export var translation_target: Node2D = self

@export var flip_throttle_delay: float = 0.2
var throttled = false

func _physics_process(delta):
    if throttled:
        return
    if is_moving_left() and not _is_facing_left():
        _face_left()
        throttle()
    elif is_moving_right() and not _is_facing_right():
        _face_right()
        throttle()

func throttle():
    throttled = true
    await get_tree().create_timer(flip_throttle_delay).timeout
    throttled = false

func is_moving_left():
    return translation_base.velocity.x > 0

func is_moving_right():
    return translation_base.velocity.x < 0

func _is_facing_left():
    return translation_target.global_transform.x.x == -1

func _is_facing_right():
    return not _is_facing_left()

func _face_left():
    translation_target.global_transform.x.x = -1

func _face_right():
    translation_target.global_transform.x.x = 1
