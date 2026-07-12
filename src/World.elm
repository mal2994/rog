module World exposing (..)

import Array exposing (Array)
import Dict exposing (Dict)
import Entity exposing (Coord, Direction(..), Entity, EntityType(..), move)
import Interpreter exposing (Verb(..))



-- probably would make sense to extract the enums into a separate module
-- but, since we are qualifying up here I guess the coupling is pretty low still


type alias EntityId =
    Int


type alias DoorState =
    Bool


type alias World =
    { map : Map
    , player : Entity
    , monsters : Dict EntityId Entity
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
    , tiles =
        Array.repeat (10 * 10) Floor
            |> Array.set 14 Wall
            |> Array.set 15 Wall
            |> Array.set 55 Wall

    -- |> Array.set 54 Knight
    }


initialPlayer : Entity
initialPlayer =
    { hp = 100, coord = 54, type_ = Player }


viewWorld : World -> String
viewWorld world =
    let
        addLineBreaks width charList =
            charList
                |> List.indexedMap
                    (\i c ->
                        if modBy width (i + 1) == 0 then
                            [ c, '\n' ]

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
        |> Array.set world.player.coord Knight
        |> Array.toList
        |> List.map tileToChar
        |> addLineBreaks world.map.width


verbToDirection : Verb -> Direction
verbToDirection v =
    case v of
        Up ->
            N

        Down ->
            S

        Left ->
            W

        Right ->
            E

        _ ->
            N


updatePlayer : World -> Verb -> World
updatePlayer world verb =
    let
        player =
            world.player

        updatedPlayer =
            { player | coord = move (verbToDirection verb) player.coord }
    in
    { world | player = updatedPlayer }
