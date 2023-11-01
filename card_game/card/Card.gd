class_name Card extends Area2D

# TODO Investigate - Tried making CardEffect a Resource, but then, I couldn't connect signals to it (PointAndClickEffect)
#@export var effect : CardEffect

@export_file("*.gd") var effect_filepath : String
@onready var effect : CardEffect = load(effect_filepath).new();

@onready var collision_shape : CollisionShape2D = $CollisionShape2D as CollisionShape2D

var animation_move_speed : float = 0.1
var hover_scale : float = 2.0
var hover_displacement : float = 40.0

var resting_position : Vector2

func play():
	assert(effect, "Card effect must be set in order to play it!");
	GlobalSignals.execute.emit(effect.execute);

func get_effect_description() -> String:
	return effect.get_description();

# TODO Does this need a callback?
func move_to_global_pos(target : Vector2, callback : Callable = func() : pass):
	var tween : Tween = create_tween() as Tween;
	tween.tween_property(self, "global_position", target, animation_move_speed);
	tween.tween_callback(callback);
	
func move_to_local_pos(target : Vector2, callback : Callable = func() : pass):
	var tween : Tween = create_tween() as Tween;
	tween.tween_property(self, "position", target, animation_move_speed);
	tween.tween_callback(callback);

func scale_to(target : float) -> void:
	var tween : Tween = create_tween() as Tween;
	tween.tween_property(self, "scale", Vector2(target, target), animation_move_speed);

func _on_mouse_entered() -> void:
	if position != resting_position:
		return
#	scale_to(hover_scale);
	move_to_local_pos(resting_position + Vector2(0, -hover_displacement));

func _on_mouse_exited() -> void:
#	scale_to(1.0);
	move_to_local_pos(resting_position);
