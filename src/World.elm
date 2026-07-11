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
    | Knight


type alias Player =
    { hp : Int }


type alias Monster =
    { hp : Int }


initialWorld : World
initialWorld =
    { map = initialMap
    , player = initialPlayer
    , monsters = Dict.empty
    }


initialMap : Map
initialMap =
    { width = 10
    , height = 10
    , tiles = Array.repeat (10 * 10) Floor
     |> Array.set 14 Wall
     |> Array.set 15 Wall
     |> Array.set 55 Wall
     |> Array.set 54 Knight
    }


initialPlayer : Player
initialPlayer =
    { hp = 100 }


viewWorld : World -> String
viewWorld world =
    let
        addLineBreaks width charList =
            charList
                -- |> String.toList
                |> List.indexedMap
                    (\i c ->
                        if modBy width (i + 1) == 0 then
                            [ c, '\n' ]
                            -- [ '\n', c ]

                        else
                            [ c ]
                    )
                |> List.concat
                |> String.fromList

        tileToChar tile =
            case tile of
                Floor ->
                    '.'

                Wall ->
                    '#'

                Door isOpen ->
                    if isOpen then
                        '/'

                    else
                        '+'

                StairsUp ->
                    '<'

                StairsDown ->
                    '>'
                
                Knight ->
                    '⋒'
    in
    world.map.tiles
        |> Array.toList
        |> List.map tileToChar
        -- |> String.fromList
        |> addLineBreaks world.map.width
