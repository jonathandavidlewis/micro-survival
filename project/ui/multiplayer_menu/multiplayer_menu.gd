extends Control

@onready var player_list: VBoxContainer = %PlayerList
@onready var start_button: Button = %StartButton

var MAIN_LEVEL = load("res://main_level.tscn")

func _ready() -> void:
  start_button.hide()
  #Lobby.player_connected.connect(_on_player_connected)
  #Lobby.player_disconnected.connect(_on_player_disconnected)
  pass

@rpc("call_local")
func start_game():
  get_tree().change_scene_to_packed(MAIN_LEVEL)

func render_player_list():
  var players_dict = {}
  #var players_dict = Lobby.players
  for child in player_list.get_children():
    player_list.remove_child(child)
  for unique_player_id: int in players_dict:
    var player_info_dict: Dictionary = players_dict.get(unique_player_id)
    var player_name = player_info_dict.get("name")
    var label = Label.new()
    label.text = player_name
    player_list.add_child(label)
  if multiplayer.is_server():
    show_start_button(player_list.get_child_count() > 1)

func _on_player_disconnected():
  render_player_list()

func _on_player_connected(peer_id, player_info):
  render_player_list()

func show_start_button(show: bool = true):
  start_button.visible = show

func _on_host_button_pressed() -> void:
  #Lobby.create_game()
  pass # Replace with function body.

func _on_join_button_pressed() -> void:
  #Lobby.join_game()
  MultiplayerClient.start(MultiplayerClient.server_url)
  await MultiplayerClient.lobby_sealed
  #rpc("start_game")
  show_start_button(true)
  
  pass # Replace with function body.


func _on_start_button_pressed() -> void:
  rpc("start_game")
  var suth = get_multiplayer_authority()
  #var id = multiplayer.get_unique_id()
  pass # Replace with function body.
