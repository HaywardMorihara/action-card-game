class_name Area extends Node2D

@onready var player : Player = $Player as Player
@onready var area_transitiona : Node2D = $AreaTransitions as Node2D
@onready var buildings : Node2D = $Buildings as Node2D
@onready var pickups : Node2D = $Pickups as Node2D

var player_starting_area_id : String;

func _ready() -> void:
	if player_starting_area_id:
		for at in get_tree().get_nodes_in_group("area_transitions"):
			if at.id == player_starting_area_id:
				player.global_position = at.global_position;
