module World exposing (..)

import Array exposing (Array)
import Dict exposing (Dict)
import Entity exposing (Direction(..), Entity, EntityType(..), move)
import Enums exposing (Coord, DoorState, EntityId, Tile(..), transform)
import Html exposing (q)
import Html.Attributes exposing (src)
import Interpreter exposing (Verb(..))



-- probably would make sense to extract the enums into a separate module


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

    -- |> Array.set 14 Wall
    -- |> Array.set 15 Wall
    -- |> Array.set 55 Wall
    -- |> Array.set 56 Skull
    }
        |> addSquare 0 55 Wall


initialPlayer : Entity
initialPlayer =
    { hp = 100, coord = 94, type_ = Player }


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

                Skull ->
                    '☠'
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


addSquare : Coord -> Coord -> Tile -> Map -> Map
addSquare topLeft bottomRight tile map =
    let
        getX x =
            modBy map.width x

        getY y =
            y // map.height * map.height

        x0 =
            getX topLeft

        y0 =
            getY topLeft

        x1 =
            getX bottomRight

        y1 =
            getY bottomRight

        addTiles chgList srcList =
            transform srcList (chgList |> Array.fromList) tile
        

        addedTiles =
            map.tiles
                -- top:
                |> addTiles (List.range (x0 + y0) (x1 + y0))
                -- bottom:
                |> addTiles (List.range (x0 + y1) (x1 + y1))
                -- left:
                -- |> addTiles (List.range (x0 + y1) (x1 + y1))
    in
    -- { map | tiles = List.repeat 100 Skull |> Array.fromList }
    { map | tiles = addedTiles }
