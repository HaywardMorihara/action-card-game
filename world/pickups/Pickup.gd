class_name Pickup extends Area2D

func can_be_picked_up() -> bool:
	# To be implemented by subclass
	return true;

func picked_up() -> void:
	# To be implemented by subclass
	pass;

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if not can_be_picked_up():
			return
		picked_up();
		# TODO Animation
		# TODO SFX
		queue_free();
