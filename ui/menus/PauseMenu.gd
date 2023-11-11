extends Control

signal resume

func _on_resume_button_pressed() -> void:
	resume.emit();
