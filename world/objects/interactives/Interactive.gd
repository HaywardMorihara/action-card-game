class_name Interactive extends Area2D

func _interaction() -> void:
	print("IMPLEMENT ME");

func _exit_interaction() -> void:
	# OPTIONAL: IMPLEMENT ME
	pass;

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Interactor":
		_interaction();
	
func _on_area_exited(area: Area2D) -> void:
	if area.name == "Interactor":
		_exit_interaction();
