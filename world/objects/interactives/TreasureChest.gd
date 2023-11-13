extends Interactive

@onready var animation_player : AnimationPlayer = $AnimationPlayer as AnimationPlayer;
@onready var open_button : Button = $OpenButton as Button;

func _interaction() -> void:
	open_button.show();

func _exit_interaction() -> void:
	open_button.hide();

func _on_button_pressed() -> void:
	open_button.hide();
	animation_player.play("opening");
	# TODO Card receive animation
	# TODO
#	animation_player.play("closing");
