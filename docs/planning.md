# Planning

## Art

24x24 pixel art
All in 1 single file
Grid aligned on a 24x24 grid

- Player
  - Side view 2 frame run, facing right
- Enemy
  - Side view 2 frame run, facing right
- Water Source
- Bush
- Ground

## Events

signal player_health_updated(value: int)
signal player_health_max_updated(value: int)
signal player_died

signal player_hurt
signal enemy_attacked

<!-- signal player_health_low
signal player_hydration_low -->

signal player_drank_water

signal move_started(moving_node: Node2D)
signal move_stopped(moving_node: Node2D)

signal player_started_hiding
signal player_stopped_hiding

signal enemy_started_walking_to_start_point
signal enemy_arrived_at_start_point

signal enemy_started_chasing
signal enemy_stopped_chasing




default music is peaceful music

---

MusicPlayer

_ready():
  GlobalSignalBus.player_hurt.connect(_on_player_hurt)


func _on_player_hurt():
  if not is_playing():
    play("hurt")

## Priority list

1. Level Design

Player gets hurt
Player dies
Player drinks water


raptor waits before leaving
