extends Node

const FILE_PATH = 'jokes.csv'

signal finishedProcessing()

onready var rawMatrix := csvFileToMatrix( FILE_PATH )
onready var rng := RandomNumberGenerator.new()

var pointsMap = {}
var intros = []
var devs = []
var plines = []

func _ready():
    $"Loading Screen".show()
    rng.randomize()
    processMatrix()
    # print( pointsMap )
    print( intros )
    print( devs )
    print( plines )
    emit_signal( "finishedProcessing" )
    $"Loading Screen".hide()

func processMatrix() :
    for row in rawMatrix :
        var intro = row[0]
        var dev = row[1]
        var pline = row[2]
        var pts = row[3]

        if !intros.has( intro ) :
            intros.push_back( intro )
        if !devs.has( dev ) :
            devs.push_back( dev )
        if !plines.has( pline ) :
            plines.push_back( pline )

        if !pointsMap.has( intro ) :
            pointsMap[ intro ] = {}
        if !pointsMap[ intro ].has( dev ) :
            pointsMap[ intro ][ dev ] = {}
        if !pointsMap[ intro ][ dev ].has( pline ) :
            pointsMap[ intro ][ dev ][ pline ] = pts

func csvFileToMatrix(filePath: String) -> Array:
    var matrix = []
    var file = File.new()
    if file.open(filePath, File.READ) == OK:
        var line = file.get_line()
        while line != "":
            var row = line.split(",")
            matrix.append(row)
            line = file.get_line()
        file.close()
    return matrix

func getSome( arr: Array, n: int ) -> Array :
    var step := int( len( arr ) / n )
    var res = []
    for i in range( n ) :
        var index = rng.randi_range( i * step, ( i + 1 ) * step - 1 )
        res.push_back( arr[ index ] )
    return res

func getPoints() :
    pass
