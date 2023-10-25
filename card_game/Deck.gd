class_name Deck extends Node2D

const Card1Scene = preload("res://card_game/cards/FireballCard.tscn")

var _deck_contents : Array[Card]

func _ready():
	_load_deck_contents()

func pop() -> Card:
	return _deck_contents.pop_front()

# TODO
func _load_deck_contents():
	for i in 2:
		_deck_contents.append(Card1Scene.instantiate())
