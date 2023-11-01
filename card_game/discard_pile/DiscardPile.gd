class_name DiscardPile extends Node2D

@onready var contents : Node = $Contents;

func add_card(card : Card, start_global_pos : Vector2):
	card.resting_position = Vector2.ZERO;
	card.disable_hover();
	# TODO Is this the right order?
	contents.add_child(card);
	card.global_position = start_global_pos;
	card.move_to_local_pos(card.resting_position);
#	# Note: Necessary when you add a child (set its position)
#	card.position = card.resting_position;

func remove(card : Card) -> void:
	card.enable_hover();
	contents.remove_child(card);

func remove_all() -> Array[Card]:
	var removed_cards : Array = contents.get_children();
	for c in removed_cards:
		contents.remove_child(c);
	return removed_cards;
