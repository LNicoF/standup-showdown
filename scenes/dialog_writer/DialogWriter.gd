extends Node2D

signal finishedWriting()

export( String, MULTILINE ) var text
export( int ) var delay # in ms

onready var _tween := $Tween
onready var _label := $Label

func _ready():
    _label.text = ''
    if len( text ) > 0 :
        write( text )

func write( _text: String ) -> void :
    var duration : float = _text.length() * delay / 1000.0
    _label.text = _text
    _tween.interpolate_property(
        _label, 'visible_characters',
        0, _text.length(),
        duration
    )
    _tween.start()

func stop() -> void :
    pass

func _on_Tween_tween_completed(_object:Object, _key:NodePath):
    emit_signal( "finishedWriting" )

