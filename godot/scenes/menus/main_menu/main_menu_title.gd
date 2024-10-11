extends Control

@onready var play: MarginContainer = $Play
@onready var settings: MarginContainer = $Settings
@onready var credits: MarginContainer = $Credits
@onready var quit: MarginContainer = $Quit

@onready var playButton: TextureButton = $Play/TextureButton
@onready var settingsButton: TextureButton = $Settings/TextureButton
@onready var creditsButton: TextureButton = $Credits/TextureButton
@onready var quitButton: TextureButton = $Quit/TextureButton

func _ready() -> void:
		assert(playButton.pressed.connect(_on_play_pressed) == 0)
		assert(settingsButton.pressed.connect(_on_settings_pressed) == 0)
		assert(creditsButton.pressed.connect(_on_credits_pressed) == 0)
		assert(quitButton.pressed.connect(_on_quit_pressed) == 0)

		assert(playButton.mouse_entered.connect(_on_mouse_entered.bind("Play", playButton)) == 0)
		assert(settingsButton.mouse_entered.connect(_on_mouse_entered.bind("Settings", settingsButton)) == 0)
		assert(creditsButton.mouse_entered.connect(_on_mouse_entered.bind("Credits", creditsButton)) == 0)
		assert(quitButton.mouse_entered.connect(_on_mouse_entered.bind("Quit", quitButton)) == 0)

		assert(playButton.mouse_exited.connect(_on_mouse_exited.bind("Play", playButton)) == 0)
		assert(settingsButton.mouse_exited.connect(_on_mouse_exited.bind("Settings", settingsButton)) == 0)
		assert(creditsButton.mouse_exited.connect(_on_mouse_exited.bind("Credits", creditsButton)) == 0)
		assert(quitButton.mouse_exited.connect(_on_mouse_exited.bind("Quit", quitButton)) == 0)

# On mouse entered for, change the size of the adjacent Label
func _on_mouse_entered(labelName: String, btn: TextureButton) -> void:
	var label := btn.get_node("../HBoxContainer/%sLabel" % labelName) as Label
	var decorations: Array[Control] = [
		btn.get_node("../HBoxContainer/EllipseL") as Control,
		btn.get_node("../HBoxContainer/StarL") as Control,
		btn.get_node("../HBoxContainer/EllipseR") as Control,
		btn.get_node("../HBoxContainer/StarR") as Control
	]

	if decorations.has(null):
		print("One decoration not found.")
		return

	if label == null:
		print("Label not found.")
		return

	for decoration in decorations:
		decoration.show()

	label.set("theme_override_font_sizes/font_size", 40)
	label.set("theme_override_font_colors/font_color", Color.from_string("#f5f5f5", Color(0.96, 0.96, 0.96, 1)))

func _on_mouse_exited(labelName: String, btn: TextureButton) -> void:
	var label := btn.get_node("../HBoxContainer/%sLabel" % labelName) as Label

	var decorations: Array[Control] = [
		btn.get_node("../HBoxContainer/EllipseL") as Control,
		btn.get_node("../HBoxContainer/StarL") as Control,
		btn.get_node("../HBoxContainer/EllipseR") as Control,
		btn.get_node("../HBoxContainer/StarR") as Control
	]

	if decorations.has(null):
		print("One decoration not found.")
		return

	if label == null:
		print("Label not found.")
		return

	for decoration in decorations:
		decoration.hide()

	label.set("theme_override_font_sizes/font_size", 32)
	label.set("theme_override_font_colors/font_color", Color.from_string("#f9f3e5", Color(0.98, 0.95, 0.9, 1)))

func _on_play_pressed() -> void:
	print("play")
	pass

func _on_settings_pressed() -> void:
	pass

func _on_credits_pressed() -> void:
	pass

func _on_quit_pressed() -> void:
	# TODO: Verify the quit
	get_tree().quit()
