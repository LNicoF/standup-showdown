extends Button

signal picked( id )

export( int ) var id

onready var _label := $Label

var isHovered := false
var isPressed := false

func _on_Option_pressed():
    emit_signal( "picked", id )

func setText( text: String ) :
    $Label.text = text

func updateLabelState():
    pass

func _onStateChanged() :
    updateLabelState()
