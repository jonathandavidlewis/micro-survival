extends Node

signal player_health_updated(value: int)
signal player_health_max_updated(value: int)
signal player_died
signal move_started(moving_node: Node2D)
signal move_stopped(moving_node: Node2D)

