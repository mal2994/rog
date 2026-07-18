module World exposing (..)

import Array exposing (Array)
import Dict exposing (Dict)
import Entity exposing (Direction(..), Entity, EntityType(..), move)
import Enums exposing (Coord)
import Interpreter exposing (Verb(..))



-- probably would make sense to extract the enums into a separate module


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


verbToDirection : Verb -> Maybe Direction
verbToDirection v =
    case v of
        Up ->
            Just N

        Down ->
            Just S

        Left ->
            Just W

        Right ->
            Just E

        _ ->
            Nothing


updatePlayer : World -> Verb -> World
updatePlayer world verb =
    let
        player =
            world.player

        dir =
            verbToDirection verb

        updatedPlayer =
            case dir of
                Nothing ->
                    player

                Just d ->
                    let
                        canMove =
                            canMoveTo world.map (move d player.coord)
                    in
                    if canMove then
                        { player | coord = move d player.coord }

                    else
                        player
    in
    { world | player = updatedPlayer }


checkMove : Map -> Coord -> Tile
checkMove map coord =
    Array.get coord map.tiles
        -- if array out of bounds, return wall
        |> Maybe.withDefault Wall


canMoveTo : Map -> Coord -> Bool
canMoveTo map coord =
    case checkMove map coord of
        Floor ->
            True

        _ ->
            False
