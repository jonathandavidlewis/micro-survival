extends Node

@onready var player_walk: AudioStreamPlayer = %PlayerWalk
@onready var raptor_walk: AudioStreamPlayer = %RaptorWalk
@onready var player_hurt: AudioStreamPlayer = %PlayerHurt
@onready var player_drink: AudioStreamPlayer = %PlayerDrink
@onready var enemy_attack: AudioStreamPlayer = %RaptorAttack

func _ready() -> void:

    GlobalSignalBus.move_started.connect(_on_move_started)
    GlobalSignalBus.move_stopped.connect(_on_move_stopped)
    GlobalSignalBus.enemy_started_chasing.connect(_on_enemy_started_chasing)
    GlobalSignalBus.enemy_stopped_chasing.connect(_on_enemy_stopped_chasing)
    GlobalSignalBus.player_hurt.connect(_on_player_hurt)
    GlobalSignalBus.player_drank_water.connect(_on_player_drank_water)
    GlobalSignalBus.enemy_attacked.connect(_on_enemy_attacked)


var player_walking := false
var raptor_walking := false


func _on_player_drank_water():

    player_drink.play()


func _on_player_hurt():

    player_hurt.play()


func _on_enemy_attacked():

    enemy_attack.play()


func _on_enemy_started_chasing():
    
    raptor_walking = true
    while raptor_walking == true:
        raptor_walk.play()
        await get_tree().create_timer(.2).timeout


func _on_enemy_stopped_chasing():

    raptor_walking = false
    raptor_walk.stop()


func _on_move_started(node: Node):
    
    if node.is_in_group("Player"):
        player_walking = true
        while player_walking == true:
            player_walk.play()
            await get_tree().create_timer(.2).timeout


func _on_move_stopped(node: Node):
    
    if node.is_in_group("Player"):
        player_walking = false
        player_walk.stop()
    
