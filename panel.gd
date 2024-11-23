extends Panel

# Get references to the buttons
var start_button : Button
var quit_button : Button

func _ready():
	# Initialize the buttons by getting them from the scene tree
	start_button = $"Back to game"
	quit_button = $"Quit"
	
	# Connect button signals to methods
	start_button.connect("pressed", _on_start_button_pressed)
	quit_button.connect("pressed", _on_quit_button_pressed)
	#start_button.connect("pressed", self, _on_start_button_pressed)	
	#quit_button.connect("pressed", self, _on_quit_button_pressed)

# Called when the start button is pressed
func _on_start_button_pressed():
	print("Start Game clicked")
	# Here you can change to the game scene or start the gameplay
	#get_tree().unload_current_scene();
	get_tree().change_scene_to_file("res://Levels/Demo.tscn")  # Replace with your actual game scene path

# Called when the quit button is pressed
func _on_quit_button_pressed():
	print("Quit clicked")
	get_tree().quit()  # Exits the game
