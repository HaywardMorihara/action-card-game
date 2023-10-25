class_name Fireball extends CharacterBody2D

@export var speed : float = 10.0

var target : Vector2

func _physics_process(delta: float) -> void:
	# TODO Don't hardcode
	if position.distance_to(target) < 50.0:
		queue_free();
	if target:
		velocity = position.direction_to(target) * speed;
	move_and_collide(velocity);
