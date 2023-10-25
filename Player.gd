class_name Player extends Node2D

func _input(event):
	if event.is_action_pressed("ui_accept"):
		print("picked up 'draw 2 cards' - emitting signal");
		GlobalSignals.draw_cards.emit(2);


#func _physics_process(delta):
#	if Input.is_action_pressed("move_right"):
#		# Move as long as the key/button is pressed.
#		position.x += speed * delta
