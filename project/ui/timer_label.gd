class_name LevelTimer
extends Label

var current_time_seconds: float = 0.0

func seconds_time_to_str(time_seconds: float) -> String:
  var hours = int(time_seconds) / 3600
  var minutes = (int(time_seconds) % 3600) / 60
  var seconds = int(time_seconds) % 60
  var milliseconds = int((time_seconds - float(int(time_seconds))) * 100)
  
  var template = "{minutes}:{seconds}:{milliseconds}"
  return template.format({
    "minutes": str(minutes).pad_zeros(2),
    "seconds": str(seconds).pad_zeros(2),
    "milliseconds": str(milliseconds).pad_zeros(2),
  })

func _process(delta: float) -> void:
  current_time_seconds += delta
  var time_string = seconds_time_to_str(current_time_seconds)
  text = time_string
