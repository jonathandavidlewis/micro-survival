extends Node

signal player_health_updated(value: int)
signal player_health_max_updated(value: int)
signal player_died
signal move_started(moving_node: Node2D)
signal move_stopped(moving_node: Node2D)

signal player_hurt
signal enemy_attacked

signal player_health_low

signal player_hydration_low
signal player_drank_water

signal player_started_hiding
signal player_stopped_hiding

signal enemy_started_walking_to_start_point
signal enemy_arrived_at_start_point

signal enemy_started_chasing
signal enemy_stopped_chasing