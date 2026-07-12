module Entity exposing (..)

import Html.Attributes exposing (dir)


type alias Coord =
    Int


type alias Entity =
    { hp : Int
    , coord : Coord
    , type_ : EntityType
    }


type EnemySubType
    = Patrol


type EntityType
    = Player
    | Enemy EnemySubType


type Direction
    = N
    | S
    | E
    | W


move : Direction -> Coord -> Int
move dir z =
    case dir of
        N ->
            z - 10

        S ->
            z + 10

        E ->
            z + 1

        W ->
            z - 1


checkMove =
    move
