extends Node

# CardGame
# CardGame Imperative
signal draw_cards(count : int)
signal disable_hand
signal enable_hand

# CardGame Declarative
signal hand_hovered_change(is_hovered : bool)

# CardEffect
signal execute(card_effect : Callable)
