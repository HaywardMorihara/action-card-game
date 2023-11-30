class_name Area extends Node2D

@export var area_id : String

@onready var player : Player = $Player as Player
@onready var area_transitions : Node2D = $AreaTransitions as Node2D
@onready var buildings : Node2D = $Buildings as Node2D
@onready var pickups : Node2D = $Pickups as Node2D

var player_starting_id : String;

func _ready() -> void:
	assert(area_id, "area_id must be set");
	assert(AreaRegistry.area_id_to_scene_path.get(area_id), "area_id must be registered in AreaRegistry");
	
	GlobalAccess.world = self;
	
	if player_starting_id:
		for area_transition in get_tree().get_nodes_in_group("area_transitions"):
			if area_transition.id == player_starting_id:
				player.global_position = area_transition.global_position;
	elif GlobalState.last_playmat_data.playmat_id:
		for playmat in get_tree().get_nodes_in_group("playmats"):
			playmat = playmat as Playmat;
			if playmat.playmat_id == GlobalState.last_playmat_data.playmat_id:
				player.global_position = playmat.global_position;
	
	GlobalState.last_playmat_data.area_id = area_id;
