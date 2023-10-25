extends Node

# CardGame
signal draw_cards(count : int)

# CardEffect
signal execute(card_effect : Callable)
