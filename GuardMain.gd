extends Node

signal game_over
onready var guard_missile_scene = preload("res://GuardMissile.tscn")

var battery_position = Vector2(640,600)
var guard_missile_speed
var main

func start(speed: float, cb):
    guard_missile_speed = speed
    main = cb

func _input(event):
    if event is InputEventScreenTouch:
        if event.pressed:
            spwan_guard_missile(event.position)

func _process(delta):
    if main.durability < 0:
        emit_signal("game_over")
    var mouse_position = get_viewport().get_mouse_position()
    if Input.is_action_just_pressed("ui_point"):
        spwan_guard_missile(mouse_position)

func spwan_guard_missile(mouse_position):
    var new_scene = guard_missile_scene.instance()
    add_child(new_scene)
    new_scene.start(battery_position, mouse_position, guard_missile_speed)
