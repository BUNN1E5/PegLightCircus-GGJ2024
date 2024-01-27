## ACTION TESTER
extends Node


@onready var scoresender: Node = $Scoresender

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_Q:
			print("tomato")
		elif event.keycode == KEY_W:
			print("potato")
		elif event.keycode == KEY_E:
			print("eggplant")
		elif event.keycode == KEY_R:
			print("rutabaga")
