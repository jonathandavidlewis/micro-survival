class_name UICanvas
extends CanvasLayer

@onready var health_bar: ProgressBar = %HealthBar
@onready var hydration_bar: ProgressBar = %HydrationBar

@onready var start_button: Button = %StartButton
@onready var game_over_container: VBoxContainer = %GameOverContainer

func _ready() -> void:
  game_over_container.visible = false
  start_button.pressed.connect(_on_start_pressed)
  GlobalSignalBus.player_health_max_updated.connect(_on_player_health_max_updated)
  GlobalSignalBus.player_health_updated.connect(_on_player_health_updated)
  GlobalSignalBus.player_died.connect(_on_player_died)
  GlobalSignalBus.player_hydration_updated.connect(_on_player_hydration_updated)

func _on_player_hydration_updated(value: int):
  hydration_bar.value = value

func _on_player_health_updated(value: int):
  health_bar.value = value

func _on_player_health_max_updated(value: int):
  health_bar.max_value = value

func _on_player_died():
  game_over_container.visible = true
  get_tree().paused = true

func _on_start_pressed():
  get_tree().paused = false
  get_tree().reload_current_scene()
