extends Camera2D

func _ready() -> void:
  var minimap_camera = get_tree().get_first_node_in_group("MinimapViewport")
  custom_viewport = minimap_camera
  
