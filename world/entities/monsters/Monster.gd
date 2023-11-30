class_name Monster extends Entity

# Note: Someday, monsters might be allies!

@export var health : int = 1;
@export var damage : int = 1;
@export var draw_pickup_probability : float = 1.0;

@onready var player_detection_area : Area2D = $PlayerDetectionArea as Area2D;

var draw_pickup_scene : Resource = preload("res://world/pickups/DrawPickup.tscn");

func _ready() -> void:
	randomize();
	super._ready();

# TODO Is it expensive to be doing this logic every time?
func _decide_state() -> void:
	# TODO Is it bad to be creating references like this every time?
	var world : Area = GlobalAccess.world as Area;
	var player : Player = world.player as Player;
	
	# TODO What if this is a friendly monster?
	if player_detection_area.overlaps_body(player):
		state = State.MOVING;
	else:
		state = State.IDLE;

# Note: Expected to be overridden, but this is the default behavior
# TODO Is it expensive to be doing this logic every time?
func _decide_actions() -> void:
	# TODO Is it bad to be creating references like this every time?
	var world : Area = GlobalAccess.world as Area;
	var player : Player = world.player as Player;
	
	# TODO Should this apply for NPCs as well?
	match state:
		State.IDLE:
			direction = Vector2.ZERO;
			var random_number = randi() % chance_to_idle_turn + 1;
			# Check if the random number is 1 (1/chance_to_idle_turn chance)
			if random_number == 1:
				var new_direction = Vector2(-facing.x, facing.y);
				facing = new_direction;
		State.MOVING:
			var move_target : Vector2 = player.global_position;
			direction = global_position.direction_to(move_target).normalized();

func _on_collision(collision : KinematicCollision2D) -> void:
	var body : Object = collision.get_collider();
	if body is Player:
		# Bounce instead?
		body.damage(damage);

func deal_damage(damage : int):
	health -= damage;
	if health <= 0:
		queue_destroy();

func queue_destroy():
	if randf_range(0, 1.0) < draw_pickup_probability:
		var draw_pickup : DrawPickup = draw_pickup_scene.instantiate();
		draw_pickup.global_position = global_position;
		GlobalAccess.world.pickups.add_child(draw_pickup);
	# TODO Death animation/sounds
	queue_free();
