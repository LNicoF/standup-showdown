extends Control

signal pickedOption( index )

export( Array, String ) var options

onready var _Option := preload( "res://scenes/dialog_picker/Option.tscn" )
onready var _optionsContainer := $Options ;

func _ready():
    if len( options ) > 0 :
        pick( options )

#
# pick
#  It sets up an array of options, so that
# when an option is picked, it sends a signal
func pick( _options: Array ) :
    for i in range( len( _options ) ) :
        var option := _createOption( i, _options[ i ] )
        _optionsContainer.add_child( option )
    show()

func _createOption( id: int, label: String ) -> Node :
    var option = _Option.instance()
    option.id = id
    option.setText( label )
    option.connect( "picked", self, '_on_Option_picked' )
    return option

func _clearOptions() :
    for option in _optionsContainer.get_children() :
        _optionsContainer.remove_child( option )
        option.queue_free()

func _on_Option_picked( id ) :
    emit_signal( "pickedOption", id )
    hide()
    _clearOptions()
    pass

