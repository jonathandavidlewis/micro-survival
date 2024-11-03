extends CharacterBody2D

@export var speed: float = 100
@export var max_health: int  = 100
@export var max_hydration: int = 100
@export var hydration_tick_interval: float = 1.0
@export var hydration_tick_amount: float = 2
@export var hydration_drink_amount := 20

@onready var detector: Area2D = %Detector
@onready var hurt_box: Area2D = %HurtBox
@onready var hydration_tick_timer: Timer = %HydrationTickTimer
@onready var drink_ui: Control = %DrinkUi
@onready var hide_ui: Control = %HideUi

var is_hidden := false:
  set(val):
    is_hidden = val
    if hide_ui:
      hide_ui.visible = val

var is_dead := false
var is_moving := false
var can_drink := false:
  set(val):
    can_drink = val
    set_drink_help(val)
    

func set_drink_help(is_visible: bool):
  drink_ui.visible = is_visible
  
  

var current_health = max_health:
  set(val):
    current_health = val
    GlobalSignalBus.player_health_updated.emit(current_health)
    if current_health == 0 and not is_dead:
      die()

var current_hydration = max_hydration:
  set(val):
    current_hydration = val
    GlobalSignalBus.player_hydration_updated.emit(current_hydration)

func _ready() -> void:
  GlobalSignalBus.player_health_max_updated.emit(max_health)
  GlobalSignalBus.player_health_updated.emit(max_health)
  hydration_tick_timer.start(hydration_tick_interval)
  drink_ui.visible = false
  hide_ui.visible = false

func drink():
  current_hydration += hydration_drink_amount
  var areas = detector.get_overlapping_areas()
  for area in areas:
    if area.is_in_group("Water"):
      area.get_drank()
  

func _input(event: InputEvent) -> void:
  if event.is_action_pressed("interact") and can_drink:
    drink()


func _physics_process(delta: float) -> void:
  var input = Input.get_vector("left", "right", "up", "down").normalized()
  velocity = speed * input
  move_and_slide()

  if abs(velocity) > Vector2.ZERO and !is_moving:
    is_moving = true
    GlobalSignalBus.move_started.emit(self)
    return
  
  if velocity == Vector2.ZERO and is_moving:
    is_moving = false
    GlobalSignalBus.move_stopped.emit(self)

func die():
  is_dead = true
  GlobalSignalBus.player_died.emit()
  get_tree().paused = true

func take_damage(amount: int):
  var new_health = current_health - amount 
  current_health = max(0, new_health)
  GlobalSignalBus.player_hurt.emit()

func _on_detector_area_entered(area: Area2D) -> void:
  if area.is_in_group("Bush"):
    is_hidden = true
  if area.is_in_group("Water"):
    can_drink = true


func _on_detector_area_exited(area: Area2D) -> void:
  if area.is_in_group("Bush"):
    is_hidden = false
  if area.is_in_group("Water"):
    can_drink = false

func _on_detector_body_entered(body: Node2D) -> void:
  pass

func _on_detector_body_exited(body: Node2D) -> void:
  pass


func _on_hurt_box_area_entered(area: Area2D) -> void:
  pass # Replace with function body.


func _on_hurt_box_area_exited(area: Area2D) -> void:
  pass # Replace with function body.


func _on_hurt_box_hit(damage: int) -> void:
  take_damage(damage)
  pass # Replace with function body.

func tick_dehydration():
  current_hydration = current_hydration - hydration_tick_amount

func _on_hydration_tick_timer_timeout() -> void:
  tick_dehydration()
  pass # Replace with function body.
