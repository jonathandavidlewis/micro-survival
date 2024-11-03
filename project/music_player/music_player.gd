extends Node

@export var track_0 : AudioStreamMP3
@onready var stream = $AudioStreamPlayer

func _ready() -> void:
  stream.stream = track_0
  stream.play()
