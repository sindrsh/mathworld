extends Button
class_name NumberButton


signal number_pressed(number: String)


func _input(event):
  if event is InputEventKey:
    if event.as_text_keycode() == text && event.pressed:
      _on_pressed()


func _on_pressed():
  print("NumberButton pressed" + text)
  emit_signal("number_pressed", text)