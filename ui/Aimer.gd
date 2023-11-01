class_name Aimer extends Node2D

signal aim_finished(target : Vector2)

const aimer_cursor : Resource = preload("res://ui/aimer.png");

func _ready():
	Input.set_custom_mouse_cursor(aimer_cursor);

func _unhandled_input(event):
	if event.is_action_pressed("left_click"):
		Input.set_custom_mouse_cursor(null);
		aim_finished.emit(get_global_mouse_position());
		queue_free();
