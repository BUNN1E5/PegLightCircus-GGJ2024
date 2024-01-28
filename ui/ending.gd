extends Control

@onready var badEndingClipping: Button = $BadEndingClipping
@onready var goodEndingClipping: Button = $GoodEndingClipping
@onready var badEndingModal: Button = $BadEndingModal
@onready var goodEndingModal: Button = $GoodEndingModal
@onready var redColoredPanel: Panel = $RedColoredPanel
@onready var greenColoredPanel: Panel = $GreenColoredPanel

@onready var date: Label = $Date
@onready var headline: Label = $Header
@onready var body: Label = $Body

const weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
const months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

func _ready():
	var success: bool = get_meta("success")
	
	if success:
		setGoodEnding()
	else:
		setBadEnding()
		
	setTodaysDate()
	
func _process(delta):
	pass

func _on_play_again_button_pressed():
	print("IMPLEMENT PLAY AGAIN BUTTON")

func setTodaysDate():
	var time = Time.get_datetime_dict_from_system()
	date.text = "%s, %s %d, %d" % [weekdays[time["weekday"]], months[time["month"] - 1], time["day"], time["year"]] 

func setGoodEnding():
	greenColoredPanel.visible = true
	goodEndingClipping.visible = true
	headline.text = "Peg Light Circus out shined the night"
	body.text = "This circus act left our community with a heart warming feeling to end the day. Local butcher Hunter Woodson breaks down in tears saying this performance has changed his view on life. Sources say that the circus act will be continuing their performance indefinitely so stay tuned for more tentalizing acts to make your mind stay in a state of wonder!! The show did so well that performers will be making a return so stay tuned!\n\nIn other news, new fire department opens up to douse off all the recent fires sprouting around town. Thank you to Pine Soul for this mornings yoga session and frozen yogurt social! Looking forward"

func setBadEnding():
	redColoredPanel.visible = true
	badEndingClipping.visible = true
	headline.text = "Circus Shmucks out of luck!"
	body.text = "Visiting local circus royally bombs their first visit to Pegsonville. What a travesty. Local citizen, Beverly Woodicka, looking to sue, suffered from external splintering of the utmost degree. \"I just wanted to have fun.\" she says on her deathbed. Officials say this stems from the horrific acts rooted from this deathly circus. Peg Light Circus, more like leave. While you still can. It's not on us. Authoritrees are still for the perpratrators as they picked up and left.\n\nUp next in other news, new recipe for keeping your wood waxed and free of waterlogging your pores. As I have always said, Betty Rocker swears on butter. One could have never guessed these strange remedies for our wooden complexions. More on the way."


func _on_good_ending_clipping_pressed():
	goodEndingModal.visible = true

func _on_good_ending_modal_pressed():
	goodEndingModal.visible = false

func _on_bad_ending_clipping_pressed():
	badEndingModal.visible = true

func _on_bad_ending_modal_pressed():
	badEndingModal.visible = false

#func _on_bad_image_button_pressed():
	#badEndingImage.visible = true
#
#func _on_bad_ending_image_pressed():
	#badEndingImage.visible = false
#
#func _on_good_ending_image_pressed():
	#goodEndingImage.visible = false
#
#func _on_good_image_button_pressed():
	#goodEndingImage.visible = true
