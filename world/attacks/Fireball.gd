class_name Fireball extends CharacterBody2D

@export var speed : float = 15.0

@onready var sprite : Sprite2D = $Sprite2D as Sprite2D;
@onready var animation_player : AnimationPlayer = $AnimationPlayer as AnimationPlayer;

var target : Vector2

func _ready() -> void:
	var rotation = global_position.angle_to_point(target);
	sprite.rotate(rotation);
	velocity = Vector2(speed, 0). rotated(rotation);
	animation_player.play("flying");

func _physics_process(delta: float) -> void:
	move_and_collide(velocity);
	# TODO Collision logic with enemies or walls

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

#var is_queued_destroy := false
#
#func start(_position : Vector2, _direction : float):
#	rotation = _direction
#	position = _position
#	velocity = Vector2(speed, 0).rotated(rotation)
#
## https://docs.godotengine.org/en/3.2/tutorials/physics/physics_introduction.html#collision-layers-and-masks
#func _physics_process(delta):
#	if is_queued_destroy:
#		return
#	var collision = move_and_collide(velocity * delta)
#	if collision:
#		var body = collision.get_collider()
#		if body.is_in_group("Enemies"):
#			body.queue_destroy()
#		$ExplosionSFX.play()
#		is_queued_destroy = true
#		$TailCPUParticles2D.queue_free()
#		$BodyCPUParticles2D.queue_free()
#		$ExplosionCPUParticles2D.emitting = true

#func _on_explosion_sfx_finished():
#	queue_free()
