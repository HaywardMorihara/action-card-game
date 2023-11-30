extends Node

# CardGame Imperative
signal draw_cards(count : int);
signal reshuffle;
signal disable_hand;
signal enable_hand;

# CardGame Declarative
signal hand_hovered_change(is_hovered : bool);

# CardEffect
signal execute(card_effect : Callable);

# Main
signal transition_to(next_area_scene : Resource, player_starting_area_id : String);
signal scene_transition_to(next_scene_path : String);
signal player_loses;

# GUI
signal card_obtained(card : Card);
