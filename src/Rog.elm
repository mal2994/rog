module Rog exposing (..)

import Browser
import Dict exposing (Dict)
import Html exposing (Html, br, div, input, p, pre, text, textarea)
import Html.Attributes exposing (placeholder, type_, value)
import Html.Events exposing (onInput)
import Set exposing (Set)



-- Our game world is going to be a Set of Cells
-- So that no coordinate can have more than one occupant
-- In Elm, we cannot use custom types in a Set
-- So, we need a function to translate Cell
-- into a comparable type Char


main : Program () ModelRecord MsgUnion
main =
    Browser.element
        { init = \_ -> ( initialModel, Cmd.none )
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }



-- MSG


type MsgUnion
    = NoOp
    | GotTextInput String



-- MODEL


type SettingsUnion
    = SettingsInt Int
    | SettingsString String


type
    TileUnion
    -- Tile Union is used for function args mainly
    = Wall
    | Floor


type alias CoordTuple =
    ( Int, Int )


type alias CellTuple =
    ( CoordTuple, Char )


type alias WorldSet =
    Set CellTuple


type alias ModelRecord =
    { settings : Dict String SettingsUnion
    , world : WorldSet
    , statusMsg : String
    }


makeCell : Int -> Int -> TileUnion -> CellTuple
makeCell x y z =
    ( ( x, y ), tileToChar z )


tileToChar : TileUnion -> Char
tileToChar x =
    case x of
        Wall ->
            '#'

        Floor ->
            '.'


charToTile : Char -> TileUnion
charToTile x =
    case x of
        '#' ->
            Wall

        '.' ->
            Floor

        _ ->
            Floor


cellToTile : CellTuple -> TileUnion
cellToTile x =
    Tuple.second x |> charToTile


eqTile : TileUnion -> TileUnion -> Bool
eqTile x y =
    x == y


toChar : TileUnion -> Char
toChar x =
    case x of
        Floor ->
            '.'

        Wall ->
            '#'


initialSettings : Dict String SettingsUnion
initialSettings =
    Dict.fromList
        [ ( "sizeX", SettingsInt 12 )
        , ( "sizeY", SettingsInt 12 )
        ]


addWallsLvl1 : WorldSet -> WorldSet
addWallsLvl1 w =
    Set.fromList
        [ makeCell 1 1 Wall ]
        |> Set.union w



-- INITIAL MODEL


initialModel : ModelRecord
initialModel =
    { statusMsg = ""
    , world = Set.empty
    , settings = initialSettings
    }


update : MsgUnion -> ModelRecord -> ( ModelRecord, Cmd MsgUnion )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        GotTextInput inputTxt ->
            ( { model | statusMsg = inputTxt }, Cmd.none )


view : ModelRecord -> Html MsgUnion
view model =
    div []
        [ input [ placeholder "Type something ✌️", onInput GotTextInput ] []
        , br [] []
        , p [] [ text model.statusMsg ]
        ]
