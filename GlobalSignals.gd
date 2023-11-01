extends Node

# CardGame
signal draw_cards(count : int)
signal disable_hand
signal enable_hand

# CardEffect
signal execute(card_effect : Callable)
