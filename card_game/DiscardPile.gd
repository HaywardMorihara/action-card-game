extends Node2D

@onready var contents : Node = $Contents;

func add_card(card : Card):
	# TODO Is this the right order?
	contents.add_child(card);
	# Note: Necessary when you add a child (set its position)
	card.position = Vector2.ZERO;

func remove(card : Card) -> Card:
	var hand_contents : Array = contents.get_children();
	for i in len(contents):
		if hand_contents[i] == card:
			contents.remove_at(i);
			return card;
	return null

func remove_all() -> Array[Card]:
	var removed_cards : Array = contents.get_children();
	for c in removed_cards:
		contents.remove_child(c);
	return removed_cards;
