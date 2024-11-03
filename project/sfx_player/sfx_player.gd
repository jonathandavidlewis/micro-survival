extends Node

@onready var player_walk: AudioStreamPlayer = %PlayerWalk

func _ready() -> void:

    GlobalSignalBus.move_started.connect(_on_move_started)
    GlobalSignalBus.move_stopped.connect(_on_move_stopped)

var player_walking := false

func _on_move_started(node: Node):
    print("move started caught")
    if node.is_in_group("Player"):
        player_walking = true
        while player_walking == true:
            player_walk.play()
            await get_tree().create_timer(.2).timeout

func _on_move_stopped(node: Node):
    print("move finished caught")
    if node.is_in_group("Player"):
        player_walking = false
        player_walk.stop()
    