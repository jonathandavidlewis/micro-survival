extends StaticBody2D

@export var speed: int = 80
@export var attack_interval: float = 1.0
@export var attack_damage: int = 5
@onready var detector: Area2D = %Detector
@onready var hit_box: Area2D = %HitBox
@onready var attack_timer: Timer = %AttackTimer

var target: Node2D
var direction := Vector2.ZERO
var attack_is_on_cooldown := false

func _physics_process(delta: float) -> void:
  if target:
      
    detector.look_at(target.global_position)
    direction = global_position.direction_to(target.global_position)
  
  var velocity = direction * speed
  var translation = velocity * delta
  position = position + translation
  
  if hit_box.has_overlapping_areas():
    
    var targets = hit_box.get_overlapping_areas()
    for target in targets:
      if target.has_method("receive_hit") and not attack_is_on_cooldown:
        attack_is_on_cooldown = true
        attack_timer.start(attack_interval)
        target.receive_hit(attack_damage)
        GlobalSignalBus.enemy_attacked.emit()
  

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
