class_name CardGame extends Node2D

@export var starting_hand_size : int = 5;
@export var max_hand_size : int = 7;

@onready var deck : Deck = $Deck as Deck;
@onready var hand : Hand = $Hand as Hand;
@onready var discard_pile : DiscardPile = $DiscardPile as DiscardPile;

func _ready():
	GlobalAccess.card_game = self;
	GlobalCardGame.draw_cards.connect(draw_cards);
	GlobalCardGame.reshuffle.connect(reshuffle);

	await shuffle_deck();
	draw_cards(starting_hand_size);


# APIs

# Deck APIs

func get_deck_contents() -> Array[Card]:
	# TODO
	return []

func can_draw() -> bool:
	return deck and len(deck.contents) > 0 and hand.get_size() < max_hand_size;

func draw_cards(count : int) -> void:
	for i in count:
		var next_card : Card = _draw_card();
		if next_card:
			await next_card.move_finished;

func move_from_deck_to_hand(card : Card) -> Card:
	# TODO
	return null

func discard_from_top_of_deck(count : int):
	# TODO
	pass

func discard_from_deck(card : Card) -> bool:
	# TODO
	return false

func shuffle_deck():
	await deck.shuffle();

func reshuffle():
	await move_all_from_hand_to_bottom_of_deck();
	await move_all_from_discard_to_bottom_of_deck();
	await shuffle_deck();
	await draw_cards(starting_hand_size);

func remove_from_deck(card : Card) -> Card:
	# TODO 
	return null


# Hand APIs

func move_from_hand_to_top_of_deck(card : Card):
	pass

func move_from_hand_to_bottom_of_deck(card : Card):
	card.move_to_global_pos(deck.global_position);
	await card.move_finished;
	hand.contents.remove_child(card);
	deck.add_to_bottom(card);

func move_all_from_hand_to_bottom_of_deck():
	# TODO There needs to be something that makes the animations occur in sequence
	for c in hand.contents.get_children():
		move_from_hand_to_bottom_of_deck(c);
		await c.move_finished;

func discard_from_hand(card : Card):
	# TODO 
	pass
	
func discard_random_from_hand(count : int) -> Array[Card]:
	# TODO
	return []

func discard_all_from_hand() -> Array[Card]:
	# TODO
	return []

func remove_from_hand(card : Card):
	# TODO
	pass

func remove_random_from_hand(count : int) -> Array[Card]:
	# TODO 
	return []


# Discard PIle APIs

func get_discard_pile_contents() -> Array[Node]:
	return discard_pile.contents.get_children();

func move_from_discard_to_hand(card : Card):
	# TODO
	pass

func move_from_discard_to_top_of_deck(card : Card):
	pass

func move_from_discard_to_bottom_of_deck(card : Card):
	card.move_to_global_pos(deck.global_position);
	await card.move_finished;
	discard_pile.remove(card);
	deck.add_to_bottom(card);
	

func move_all_from_discard_to_top_of_deck():
	pass

func move_all_from_discard_to_bottom_of_deck():
	for c in get_discard_pile_contents():
		var card : Card = c as Card;
		move_from_discard_to_bottom_of_deck(card);
		await card.move_finished;

func remove_from_discard(card : Card):
	discard_pile.remove(card);


# Private Functions

func _draw_card() -> Card:
	if not can_draw():
		return null
	var next_card : Card = deck.draw_card() as Card;
	if not next_card:
		return null
	hand.add_card(next_card, deck.global_position);
	return next_card;

# Signal Callbacks

func _on_hand_card_played(card : Card) -> void:
	discard_pile.add_card(card, get_global_mouse_position());
