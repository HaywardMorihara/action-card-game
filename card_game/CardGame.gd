class_name CardGame extends Node2D

@onready var deck : Deck = $Deck
@onready var hand : Hand = $Hand

var _animation_queue : Array[Callable] = []
var _is_card_animation_in_progress : bool = false

func _ready():
	GlobalSignals.draw_cards.connect(_draw_cards)

func _physics_process(delta):
	while not _animation_queue.is_empty() and not _is_card_animation_in_progress:
		var next_animation : Callable = _animation_queue.pop_front();
		var animation_signal = next_animation.call();
		if animation_signal:
			_is_card_animation_in_progress = true
			animation_signal.connect(_on_animation_finished)
			
func _on_animation_finished():
	_is_card_animation_in_progress = false;

func _draw_cards(count : int):
	for i in count:
		_animation_queue.append(_draw_card)

# Returns Signal or null (Godot won't let me make that the return type)
func _draw_card():
	var next_card : Card = deck.pop();
	if not next_card:
		return null
	hand.add_card(next_card);
	return next_card.move_to(hand.position);
