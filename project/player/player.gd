extends CharacterBody2D

@export var speed = 100
@export var max_health = 100

@onready var detector: Area2D = %Detector
@onready var hurt_box: Area2D = %HurtBox

var is_dead := false
var is_moving := false

var current_health = max_health:
  set(val):
    current_health = val
    GlobalSignalBus.player_health_updated.emit(current_health)
    if current_health == 0 and not is_dead:
      die()

func _ready() -> void:
  GlobalSignalBus.player_health_max_updated.emit(max_health)
  GlobalSignalBus.player_health_updated.emit(max_health)

func _input(event: InputEvent) -> void:
  pass

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

func _on_detector_area_entered(area: Area2D) -> void:
  pass

func _on_detector_area_exited(area: Area2D) -> void:
  pass

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
