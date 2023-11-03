class_name Pickup extends Area2D

func picked_up() -> void:
	# To be implemented by subclass
	pass;

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		picked_up();
		# TODO Animation
		# TODO SFX
		queue_free();
