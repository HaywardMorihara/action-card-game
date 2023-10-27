class_name Hand extends Node2D

@onready var contents : Node = $Contents;

func add_card(card : Card, callback : Callable):
	contents.add_child(card);
	# TODO This is a hack I don't love
	card.position = Vector2.ZERO;
	_rebalance(callback);

func remove(card : Card) -> Card:
	var hand_contents : Array = contents.get_children();
	for i in len(contents):
		if hand_contents[i] == card:
			contents.remove_at(i);
			return card;
	return null

func remove_random(count : int) -> Array[Card]:
	# TODO
	return []

func remove_all() -> Array[Card]:
	# TODO
	return []

func _rebalance(callback : Callable):
	var hand_width = $CollisionShape2D.shape.get_size().x;
	var cards_in_hand = contents.get_children();
	var num_cards_in_hand = cards_in_hand.size();
	for i in range(num_cards_in_hand):
		var new_pos = self.global_position;
		var x_diff = - (hand_width / 2) + (hand_width / (num_cards_in_hand + 1)) * (i + 1);
		new_pos.x += x_diff;
		cards_in_hand[i].move_to(new_pos, callback);

func _input(event):
	# TODO Remove
	if event.is_action_pressed("ui_select"):
		var children = contents.get_children();
		if len(children) == 0:
			return;
		children[0].play();
