class_name Card extends Node2D

# TODO Investigate - Tried making CardEffect a Resource, but then, I couldn't connect signals to it (PointAndClickEffect)
#@export var effect : CardEffect

@export_file("*.gd") var effect_filepath : String
@onready var effect : CardEffect = load(effect_filepath).new();

var animation_move_speed : float = 0.1

func play():
	assert(effect, "Card effect must be set in order to play it!");
	GlobalSignals.execute.emit(effect.execute);

func get_effect_description() -> String:
	return effect.get_description();

func move_to(target : Vector2, callback : Callable):
	var tween : Tween = create_tween();
	tween.tween_property(self, "global_position", target, animation_move_speed);
	tween.tween_callback(callback);
