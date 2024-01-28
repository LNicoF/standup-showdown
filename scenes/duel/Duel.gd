extends Node

onready var _jokes := $OptionsSelector
onready var _players := [ $Player1, $Player2 ]

var _pts := [ 0, 0 ]

func _on_Player1_jokeAssembled( introId:int, devId:int, plineId:int ):
    print( '%d, %d, %d' % [ introId, devId, plineId ] )
    $Player2.play()

func _on_Player2_jokeAssembled( introId:int, devId:int, plineId:int ):
    print( '%d, %d, %d' % [ introId, devId, plineId ] )
    endGame()

func endGame() :
    var rng = RandomNumberGenerator.new()
    rng.randomize()
    var winnerIndex : int = rng.randi_range( 0, 1 )
    var winner = _players[ winnerIndex ]
    var looser = _players[ winnerIndex ^ 1 ]
    winner.win()
    looser.lose()
    $WinSound.play()

func _on_OptionsSelector_finishedProcessing():
    $Player1.play()

