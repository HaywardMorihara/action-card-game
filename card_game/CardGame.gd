class_name CardGame extends Node2D

@onready var deck : Deck = $Deck
@onready var hand : Hand = $Hand

var _animation_queue : Array[Callable] = []
var _is_card_animation_in_progress : bool = false

func _ready():
	GlobalSignals.draw_cards.connect(_draw_cards)
	# TODO Remove - for testing
	_draw_cards(5);

func _physics_process(delta):
	while not _animation_queue.is_empty() and not _is_card_animation_in_progress:
		var next_animation : Callable = _animation_queue.pop_front();
		_is_card_animation_in_progress = true;
		next_animation.call(_on_animation_finished);
			
func _on_animation_finished():
	_is_card_animation_in_progress = false;

func _draw_cards(count : int):
	for i in count:
		_draw_card();

func _draw_card():
	var next_card : Card = deck.draw_card();
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
