class_name Hand extends Node2D

func add_card(card : Card):
	add_child(card);

func _input(event):
	if event.is_action_pressed("ui_select"):
		print("playing a random card");
		var children = get_children();
		if len(children) == 0:
			return;
		children[0].play();
