extends Node

signal jokeAssembled( introId, devId, plineId )

onready var _introTheme := preload( "res://theme_intro.tres" )
onready var _devTheme   := preload( "res://theme_dev.tres" )
onready var _plineTheme := preload( "res://theme_pline.tres" )

onready var _picker             := $DialogPicker
onready var _introWriter        := $IntroWriter
onready var _developementWriter := $DevelopementWriter
onready var _punchLineWriter    := $PunchlineWriter
onready var _jokes              := $"../OptionsSelector"

onready var _selectedSound  := $IntroSound
onready var _selectedWriter := _introWriter
var _selectedOptions := []

var selectedIds = []

func play() :
    if len( _selectedOptions ) == 0 :
        _selectedOptions = _getIntros()
    _picker.pick( _selectedOptions )

func _getIntros( _limit := -1 ) -> Array :
    return _jokes.getSome( _jokes.intros, 3 )

func _getDevelopements( _limit := -1 ) -> Array :
    return _jokes.getSome( _jokes.devs, 3 )

func _getPunchlines( _limit := -1 ) -> Array :
    return _jokes.getSome( _jokes.plines, 3 )

func _on_DialogPicker_pickedOption(index:int):
    $"../SelectAudio".play()
    selectedIds.push_back( index )
    _selectedSound.play()
    _selectedWriter.write( _selectedOptions[ index ] )

func _on_IntroWriter_finishedWriting():
    _selectedWriter  = _developementWriter
    _selectedSound   = $DevSound
    _selectedOptions = _getDevelopements()
    _picker.theme    = _devTheme
    play()

func _on_DevelopementWriter_finishedWriting():
    _selectedWriter = _punchLineWriter
    _selectedSound   = $PlineSound
    _selectedOptions = _getPunchlines()
    _picker.theme    = _plineTheme
    play()

func _on_PunchlineWriter_finishedWriting():
    var introId = selectedIds[ 0 ]
    var devId = selectedIds[ 1 ]
    var plineId = selectedIds[ 2 ]
    emit_signal( "jokeAssembled", introId, devId, plineId )

func win() :
    $Character/WinSprite.show()

func lose() :
    $Character/LoseSprite.show()


func _on_PlineSound_finished():
    var introId = selectedIds[ 0 ]
    var devId = selectedIds[ 1 ]
    var plineId = selectedIds[ 2 ]
    emit_signal( "jokeAssembled", introId, devId, plineId )

