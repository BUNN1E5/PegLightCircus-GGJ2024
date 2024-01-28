extends Control

@export var controls_node_path : NodePath
@onready var controls_node = get_node(controls_node_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	self.visible = false
	self.set_process(false)
	print("IMPLEMENT START BUTTON PRESSED")


func _on_controls_button_pressed():
	controls_node.set_visible(true)
	controls_node.set_process(true)
	self.visible = false
	self.set_process(false)
	print("IMPLEMENT CONTROLS BUTTON PRESSED")
