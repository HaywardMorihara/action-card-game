class_name Entity extends CharacterBody2D

enum State {
	IDLE,
	MOVING,
}

@export var default_speed : float = 100.0;
@export var chance_to_idle_turn : int = 120;

@onready var animation_player : AnimationPlayer = $AnimationPlayer as AnimationPlayer;

var state : State = State.IDLE as State;

var direction : Vector2;
var speed : float;
var facing : Vector2;

func _ready():
	speed = default_speed;

func _decide_state() -> void:
	print_debug("TODO IMPLEMENT ME");

func _decide_actions() -> void:
	print_debug("TODO IMPLEMENT ME");

func _physics_process(delta) -> void:
	# TODO Is it expensive to be calling these every time?
	_decide_state();
	_decide_actions();
	velocity = direction * speed;
	var collision : KinematicCollision2D = move_and_collide(velocity * delta);
	if collision:
		_on_collision(collision);

func _on_collision(collision : KinematicCollision2D) -> void:
	pass

# Note: Override if different animations
func _process(delta: float) -> void: 
	if velocity.is_zero_approx():
		if abs(facing.x) >= abs(facing.y) or (not animation_player.has_animation("idle_up") or not animation_player.has_animation("idle_down")):
			if facing.x > 0:
				if animation_player.has_animation("idle_right"):
					animation_player.play("idle_right");
			else:
				if animation_player.has_animation("idle_left"):
					animation_player.play("idle_left");
		if abs(facing.y) > abs(facing.x) or (not animation_player.has_animation("idle_left") or not animation_player.has_animation("idle_right")):
			if facing.y > 0:
				if animation_player.has_animation("idle_down"):
					animation_player.play("idle_down");
			else:
				if animation_player.has_animation("idle_up"):
					animation_player.play("idle_up");
	else:
		facing = direction;
		if abs(velocity.x) >= abs(velocity.y) or (not animation_player.has_animation("moving_up") or not animation_player.has_animation("moving_down")):
			if velocity.x > 0:
				if animation_player.has_animation("moving_right"):
					animation_player.play("moving_right");
			else:
				if animation_player.has_animation("moving_left"):
					animation_player.play("moving_left");
		if abs(velocity.y) > abs(velocity.x) or (not animation_player.has_animation("moving_left") or not animation_player.has_animation("moving_right")):
			if velocity.y > 0:
				if animation_player.has_animation("moving_down"):
					animation_player.play("moving_down");
			else:
				if animation_player.has_animation("moving_up"):
					animation_player.play("moving_up");
