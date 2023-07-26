extends Button
class_name NumberButton


signal number_pressed(number: String)


func _on_pressed():
  print("NumberButton pressed" + text)
  emit_signal("number_pressed", text)