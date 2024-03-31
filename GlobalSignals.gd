extends Node

# Main
signal transition_to(next_area_scene : Resource, player_starting_area_id : String);
signal scene_transition_to(next_scene_path : String);
signal player_lost;

# GUI
signal card_obtained(card : Card);
