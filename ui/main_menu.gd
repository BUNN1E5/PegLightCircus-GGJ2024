extends Control

@export var ambiant_light_energy : float = 2
@export var light_change_time : float = 2

@export var controls_node_path : NodePath
@onready var controls_node = get_node(controls_node_path)

@export var enviroment_node_path : NodePath
@onready var enviroment_node : WorldEnvironment = get_node(enviroment_node_path)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	var tween = create_tween().bind_node(enviroment_node).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(enviroment_node.environment, "ambient_light_energy", light_change_time, ambiant_light_energy)	
	
	self.visible = false
	self.set_process(false)
	print("IMPLEMENT START BUTTON PRESSED")


func _on_controls_button_pressed():
	controls_node.set_visible(true)
	controls_node.set_process(true)
	self.visible = false
	self.set_process(false)
	print("IMPLEMENT CONTROLS BUTTON PRESSED")
