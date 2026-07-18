module Enums exposing (..)

import Array exposing (Array)



-- enums and also some type aliases that are used in multiple modules


type alias EntityId =
    Int


type alias DoorState =
    Bool


type Tile
    = Floor
    | Wall
    | Door DoorState
    | StairsUp
    | StairsDown
    | Knight
    | Skull


type alias Coord =
    Int



-- TODO you can use Array.slice to make a function similar to List.any for better performance


arrayContains : Array a -> a -> Bool
arrayContains arr v =
    let
        greaterThanZero x =
            x > 0
    in
    Array.filter (\n -> n == v) arr
        |> Array.length
        |> greaterThanZero



-- insertVal argument is the value we will put in source array at the indexes mentioned in change array


transform : Array Tile -> Array Int -> Tile -> Array Tile
transform srcArr chgArr newVal =
    Array.indexedMap
        (\i n ->
            if arrayContains chgArr i then
                newVal

            else
                n
        )
        srcArr
