extends Node

# Note: This feels a lot like an ant-pattern that I shouldn't be doing.
# See how it goes

# This set in CardGame._read()
# Initializing so we can statically type
var card_game : CardGame = CardGame.new() as CardGame;
