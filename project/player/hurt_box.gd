extends Area2D

signal hit(damage: int)

func receive_hit(damage: int):
  hit.emit(damage)
