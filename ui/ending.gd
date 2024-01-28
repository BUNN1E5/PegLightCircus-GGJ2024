extends Control


@onready var badEndingImage: Button = $BadEndingImage

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_play_again_button_pressed():
	print("IMPLEMENT PLAY AGAIN BUTTON")

func _on_image_button_pressed():
	badEndingImage.visible = true

func _on_bad_ending_image_pressed():
	badEndingImage.visible = false
