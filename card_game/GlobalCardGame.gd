extends Node

# CardGame Imperative
signal draw_cards(count : int);
signal reshuffle;
signal disable_hand;
signal enable_hand;

# CardGame Declarative
signal hand_hovered_change(is_hovered : bool);
signal mouse_entered_card(card : Card);
signal mouse_exited_card(card : Card);

# CardEffect
signal execute(card_effect : Callable);
