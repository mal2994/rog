module World exposing (..)

import Array exposing (Array)
import Dict exposing (Dict)


type alias EntityId =
    Int


type alias DoorState =
    Bool


type alias World =
    { map : Map
    , player : Player
    , monsters : Dict EntityId Monster
    , messages : List String
    }


type alias Map =
    { width : Int
    , height : Int
    , tiles : Array Tile
    }


type Tile
    = Floor
    | Wall
    | Door DoorState
    | StairsUp
    | StairsDown


type alias Player =
    { hp : Int }


type alias Monster =
    { hp : Int }
