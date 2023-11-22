class_name Hand extends Area2D

signal card_played(card : Card)

@onready var collision_shape : CollisionShape2D = $CollisionShape2D
@onready var contents : Node = $Contents;

var animation_speed : float = 0.1
var hover_displacement : float = 20.0

var resting_position : Vector2

func _ready() -> void:
	resting_position = position;
	GlobalSignals.disable_hand.connect(disable);
	GlobalSignals.enable_hand.connect(enable);

func get_size() -> int:
	return contents.get_child_count();

func add_card(card : Card, start_global_pos : Vector2, callback : Callable):
	contents.add_child(card);
	card.global_position = start_global_pos;
	card.played.connect(_on_card_played);
	_rebalance(callback);

func remove(card : Card):
	contents.remove_child(card);
	_rebalance();

func remove_random(count : int) -> Array[Card]:
	# TODO
	return []

func remove_all() -> Array[Card]:
	# TODO
	return []
	
func disable() -> void:
	collision_shape.disabled = true
	for c in contents.get_children():
		c.disable_hover();

func enable() -> void:
	collision_shape.disabled = false;
	for c in contents.get_children():
		c.enable_hover();

# TODO Does this need a callback?
func _rebalance(callback : Callable = func() : pass):
	var hand_width = collision_shape.shape.get_size().x;
	var cards_in_hand = contents.get_children();
	var num_cards_in_hand = cards_in_hand.size();
	for i in range(num_cards_in_hand):
		var new_pos = self.global_position;
		var x_diff = - (hand_width / 2) + (hand_width / (num_cards_in_hand + 1)) * (i + 1);
		new_pos.x += x_diff;
		cards_in_hand[i].resting_position = Vector2(x_diff, 0);
		cards_in_hand[i].move_to_global_pos(new_pos, callback);

# TODO Remove
func _input(event):
	if event.is_action_pressed("ui_select"):
		var children = contents.get_children();
		if len(children) == 0:
			return;
		children[0].play();

func _on_mouse_entered() -> void:
	GlobalSignals.hand_hovered_change.emit(true);
	if position != resting_position:
		return
	var tween : Tween = create_tween() as Tween;
	tween.tween_property(self, "position", position + Vector2(0,-hover_displacement), animation_speed);

func _on_mouse_exited() -> void:
	GlobalSignals.hand_hovered_change.emit(false);
	var tween : Tween = create_tween() as Tween;
	tween.tween_property(self, "position", resting_position, animation_speed);

func _on_card_played(card : Card) -> void:
	remove(card);
	card_played.emit(card);
