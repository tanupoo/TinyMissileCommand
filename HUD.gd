extends CanvasLayer

signal start_game
signal reset_game

func _ready() -> void:
    var dynamic_font = load_font()
    $StartButton.connect("pressed", self, "start_game")
    $ResetButton.connect("pressed", self, "reset_game")
    $ResetButton.hide()
    
func update_score(score):
    $ScoreLabel/Score.text = "%06d" % score

func show_message(text):
    $Message.text = text
    $Message.show()

func hide_message():
    $Message.hide()

func start_game():
    $Message.hide()
    $StartButton.hide()
    $ResetButton.hide()
    emit_signal("start_game")

func reset_game():
    emit_signal("reset_game")

func show_reset_button():
    $StartButton.hide()
    $ResetButton.show()

func load_font():
    var dynamic_font = DynamicFont.new()
    dynamic_font.font_data = load("res://NotoSansJP-Regular.otf")
    return dynamic_font

