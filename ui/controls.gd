extends Control

@export var main_menu_node_path : NodePath
@onready var main_menu_node = get_node(main_menu_node_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_menu_button_pressed():
	main_menu_node.set_visible(true)
	main_menu_node.set_process(true)
	self.visible = false
	self.set_process(false)
	print("IMPLEMENT BACK BUTTON PRESSED")
