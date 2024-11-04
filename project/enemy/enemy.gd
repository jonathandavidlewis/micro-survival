extends StaticBody2D

@export var speed: int = 100
@export var attack_interval: float = 1.0
@export var attack_damage: int = 20
@export var original_position_delay: float = 2.0
@export var patrol_radius: float = 200
@export var wait_time: float = 2.0

@onready var detector: Area2D = %Detector
@onready var hit_box: Area2D = %HitBox
@onready var attack_timer: Timer = %AttackTimer
@onready var original_position_timer: Timer = %OriginalPositionTimer
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D


var velocity: Vector2 = Vector2.ZERO
var target: Node2D
var direction := Vector2.ZERO
var attack_is_on_cooldown := false

var start_position: Vector2

var patrol_position: Vector2 = Vector2.ZERO
var patrol_timer: float = 0.0
var waiting: bool = true

func _ready() -> void:
  set_random_patrol_position()
  patrol_timer = wait_time
  start_position = global_position

func _physics_process(delta: float) -> void:
  if target and not target.is_hidden:
      
    detector.look_at(target.global_position)
    direction = global_position.direction_to(target.global_position)
    velocity = direction * speed
  else:
    patrol(delta) 
  
  var translation = velocity * delta
  position = position + translation
  
  if velocity.length() > 0:
    animated_sprite_2d.play("run")
  else:
    animated_sprite_2d.play("idle")
  
  if hit_box.has_overlapping_areas():
    
    var targets = hit_box.get_overlapping_areas()
    for target in targets:
      if target.has_method("receive_hit") and not attack_is_on_cooldown:
        attack_is_on_cooldown = true
        attack_timer.start(attack_interval)
        target.receive_hit(attack_damage)
        GlobalSignalBus.enemy_attacked.emit()

func patrol(delta: float) -> void:
    if waiting:
        patrol_timer -= delta
        if patrol_timer <= 0:
            set_random_patrol_position()
            waiting = false
    else:
        direction = global_position.direction_to(patrol_position)
        velocity = direction * speed

        if position.distance_to(patrol_position) < 5.0:
            waiting = true
            patrol_timer = wait_time

func set_random_patrol_position() -> void:
    patrol_position = start_position + Vector2(
        randf_range(-patrol_radius, patrol_radius),
        randf_range(-patrol_radius, patrol_radius)
    )
    velocity = Vector2.ZERO

func _on_detector_body_entered(body:Node2D) -> void:
  if body.is_in_group("Player"):
    target = body

func _on_detector_body_exited(body:Node2D) -> void:
  if body.is_in_group("Player"):
    direction = Vector2.ZERO
    target = null

func attack():
  pass
  


func _on_attack_timer_timeout() -> void:
  attack_is_on_cooldown = false
  pass # Replace with function body.
