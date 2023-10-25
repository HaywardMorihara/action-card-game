class_name Aimer extends Node2D

signal aim_finished(target : Vector2)

func _process(delta: float) -> void:
	position = get_viewport().get_mouse_position();

func _unhandled_input(event):
	if event.is_action_pressed("left_click"):
		aim_finished.emit(get_global_mouse_position());
		queue_free();
