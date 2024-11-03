extends StaticBody2D

@export var speed: int = 80
@onready var detector: Area2D = %Detector

var target: Node2D
var direction := Vector2.ZERO

func _physics_process(delta: float) -> void:
  if target:
      
    detector.look_at(target.global_position)
    direction = global_position.direction_to(target.global_position)
  
  var velocity = direction * speed
  var translation = velocity * delta
  position = position + translation
  

func _on_detector_body_entered(body:Node2D) -> void:
  if body.is_in_group("Player"):
    target = body

func _on_detector_body_exited(body:Node2D) -> void:
  if body.is_in_group("Player"):
    direction = Vector2.ZERO
    target = null

