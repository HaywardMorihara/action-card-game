class_name Card extends Area2D

signal played(card : Card)
signal move_finished

@export var card_name : String;
@export var card_description : String;

@export_file("*.gd") var effect_filepath : String
@onready var effect : CardEffect = load(effect_filepath).new();

@onready var card_image : Sprite2D = $CardImage as Sprite2D;
@onready var collision_shape : CollisionShape2D = $CollisionShape2D as CollisionShape2D;
@onready var card_description_label : RichTextLabel = $CardDescription as RichTextLabel;

var animation_move_speed : float = 0.1
var hover_scale : float = 2.0
var hover_displacement : float = 16.0

var resting_position : Vector2

var is_hovered_over := false
var is_card_selected := false

func _ready() -> void:
	card_description_label.text = card_description;
	card_description_label.hide();

func play():
	assert(effect, "Card effect must be set in order to play it!");
	GlobalCardGame.execute.emit(effect.execute);
	played.emit(self);
	# TODO Animation

func get_effect_description() -> String:
	return effect.get_description();
	
func get_image_path() -> String:
	# Cannot use 'card_image' because might not be ready yet
	var compressed_texture = $CardImage.texture as CompressedTexture2D;
	return compressed_texture.resource_path;

func move_to_global_pos(target : Vector2):
	var tween : Tween = create_tween() as Tween;
	tween.tween_property(self, "global_position", target, animation_move_speed);
	await tween.finished;
	move_finished.emit();
	
func move_to_local_pos(target : Vector2):
	var tween : Tween = create_tween() as Tween;
	tween.tween_property(self, "position", target, animation_move_speed);
	await tween.finished;
	move_finished.emit();

func scale_to(target : float) -> void:
	var tween : Tween = create_tween() as Tween;
	tween.tween_property(self, "scale", Vector2(target, target), animation_move_speed);
	
func disable_hover() -> void:
	collision_shape.disabled = true;

func enable_hover() -> void:
	collision_shape.disabled = false;

func hover() -> void:
	if not position.is_equal_approx(resting_position):
		return
#	scale_to(hover_scale);
	move_to_local_pos(resting_position + Vector2(0, -hover_displacement));
	is_hovered_over = true;
	_display_card_description();

func unhover() -> void:
	_hide_card_description();
	is_hovered_over = false;
	move_to_local_pos(resting_position);

func _physics_process(delta: float) -> void:
	if is_card_selected:
		global_position = get_global_mouse_position();

func _input(event):
	if event.is_action_pressed("player_select"):
		if is_hovered_over:
			is_card_selected = true
			scale_to(hover_scale);
	if event.is_action_released("player_select"):
		if is_card_selected:
			is_card_selected = false;
			scale_to(1.0);
			if _overlaps_with_hand():
				move_to_local_pos(resting_position);
			else:
				play();

func _on_mouse_entered() -> void:
	GlobalCardGame.mouse_entered_card.emit(self);
	
func _on_mouse_exited() -> void:
	GlobalCardGame.mouse_exited_card.emit(self);

func _overlaps_with_hand() -> bool:
	var overlapping_areas : Array[Area2D] = get_overlapping_areas();
	for oa in overlapping_areas:
		if oa is Hand:
			return true
	return false
#	var cols : CollisionShape2D = oa.collision_shape as CollisionShape2D;
#	var rect_shape = oa.collision_shape.shape as RectangleShape2D
#	var rect : Rect2 = rect_shape.get_rect() as Rect2;
#	if rect.has_point(get_global_mouse_position() - oa.global_position):
#		if oa.global_position.x > global_position.x:
#			return

func _display_card_description() -> void:
	card_description_label.show();

func _hide_card_description() -> void:
	card_description_label.hide();
