extends CanvasLayer

signal start_game

func _ready() -> void:
    var dynamic_font = load_font()
    $StartButton.connect("pressed", self, "start_game")

func update_score(score):
    $ScoreLabel/Score.text = "%06d" % score

func show_message(text, stimer=0):
    $Message.text = text
    $Message.show()
    if not stimer:
        yield(get_tree().create_timer(stimer), "timeout")
        $Message.hide()

func start_game():
    $Message.hide()
    $StartButton.hide()
    emit_signal("start_game")

func show_button():
    $StartButton.show()

func show_game_over():
    show_message("Game Over", 2)
    yield(get_tree().create_timer(2), "timeout")
    show_message("Tiny Missile Command")
    yield(get_tree().create_timer(1), "timeout")
    $StartButton.show()
    
func load_font():
    var dynamic_font = DynamicFont.new()
    dynamic_font.font_data = load("res://NotoSansJP-Regular.otf")
    return dynamic_font

