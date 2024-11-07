extends Node
@onready var main_level: Node2D = $".."

var connected_peer_ids: Array[int] = []

var PLAYER: PackedScene = load("res://player/player.tscn")

var current_player: CharacterBody2D

func _ready() -> void:
  if Lobby.players.size() > 0:
    for peer_id in Lobby.players:
      add_player(peer_id)
  else:
    add_player(1)

func add_player(peer_id: int):
  connected_peer_ids.append(peer_id)
  #if peer_id == multiplayer.get_unique_id()
  var player = PLAYER.instantiate()
  player.set_multiplayer_authority(peer_id)
  main_level.add_child.call_deferred(player)
  if peer_id == multiplayer.get_unique_id():
    current_player = player
  #Lobby
  #pass

#@rpc
#func add_previously_connected_player_characters(peer_ids: Array[int]):
  #for peer_id in peer_ids:
    #add_player(peer_id)
