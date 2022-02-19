extends Area2D

var t = 0
var v0 = 2.5
var a = 3

func start(pos0, v0=2.2, a=3):
    position = pos0
    scale = Vector2()

func _ready():
    $Sprite.show()
    $SoundExplosion.play()
    $ExplosionFire.emitting = true
    $ExplosionSmoke.emitting = true

func _process(delta):
    t += delta
    scale = Vector2(1,1)*get_coeff(t)

func get_coeff(t):
    var coeff = v0*t - a*pow(t,2)/2
    if coeff < 0:
        queue_free()
    return coeff

