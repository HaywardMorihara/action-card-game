class_name CardGame extends Node2D

@onready var deck : Deck = $Deck
@onready var hand : Hand = $Hand

# TODO Should this be refactored to use awaits? https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html#awaiting-for-signals-or-coroutines
var _animation_queue : Array[Callable] = []
var _is_card_animation_in_progress : bool = false

func _ready():
	# TODO Is this needed? Should it be here?
#	GlobalSignals.draw_cards.connect(draw_cards)
	# TODO Remove - for testing
	shuffle_deck();
	await deck.shuffle_finished
	draw_cards(5);

func _physics_process(delta):
	while not _animation_queue.is_empty() and not _is_card_animation_in_progress:
		var next_animation : Callable = _animation_queue.pop_front() as Callable;
		_is_card_animation_in_progress = true;
		next_animation.call(_on_animation_finished);
			
func _on_animation_finished():
	_is_card_animation_in_progress = false;

# APIs

# Deck APIs

func get_deck_contents() -> Array[Card]:
	# TODO
	return []

func draw_cards(count : int):
	for i in count:
		_draw_card();

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
	deck.shuffle();

# Remove from Deck
func remove_from_deck(card : Card) -> Card:
	# TODO 
	return null


# Hand APIs

func move_from_hand_to_top_of_deck(card : Card):
	# TODO
	pass

func move_from_hand_to_bottom_of_deck(card : Card):
	# TODO 
	pass

# Hand to Discard (specific, random)
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

func get_discard_pile_contents() -> Array[Card]:
	# TODO
	return []

func move_from_discard_to_hand(card : Card):
	# TODO
	pass

func move_from_discard_to_top_of_deck(card : Card):
	# TODO
	pass

func move_from_discard_to_bottom_of_deck(card : Card):
	# TODO
	pass

func move_all_from_discard_to_top_of_deck():
	# TODO
	pass

func move_all_from_discard_to_bottom_of_deck():
	# TODO
	pass

func remove_from_discard(card : Card):
	# TODO 
	pass


# Private Functions

# TODO Refactor to use await?
func _draw_card():
	var next_card : Card = deck.draw_card() as Card;
	if not next_card:
		return null
	add_child(next_card);
	# Important: This has to come after being added as a child, or else position doesn't work
	next_card.global_position = deck.global_position;
	
	_animation_queue.append(func(callback : Callable):
		next_card.move_to(hand.global_position, callback);
	);
	
	_animation_queue.append(func(callback : Callable):
		remove_child(next_card);
		hand.add_card(next_card, callback);
	);
