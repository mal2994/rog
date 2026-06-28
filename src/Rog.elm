module Rog exposing (..)

import Browser
import Dict exposing (Dict)
import Html exposing (Html, br, div, input, p, pre, text, textarea)
import Html.Attributes exposing (placeholder, type_, value)
import Html.Events exposing (onInput)


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> ( initialModel, Cmd.none )
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }



-- MSG


type Msg
    = NoOp
    | GotTextInput String



-- MODEL


type Settings
    = SettingsInt Int
    | SettingsString String


type alias Model =
    { settings : Dict String Settings
    , world : World
    , statusMsg : String
    }


type alias Coord =
    ( Int, Int )


type Tile
    = Wall
    | Floor


type alias Cell =
    ( Coord, Tile )


type alias World =
    List Cell


cellToTile : Cell -> Tile
cellToTile x =
    Tuple.second x

eqTile : Tile -> Tile -> Bool
eqTile x y = x == y

toChar: Tile -> Char
toChar x =
  case x of 
    Floor -> '.'
    Wall -> '#'

initialSettings : Dict String Settings
initialSettings =
    Dict.fromList
        [ ( "sizeX", SettingsInt 12 )
        , ( "sizeY", SettingsInt 12 )
        ]


addWallsLvl1 : World -> World
addWallsLvl1 w =
    List.append w
        [ ( ( 1, 1 ), Wall )
        , ( ( 1, 2 ), Wall )
        , ( ( 1, 3 ), Wall )
        , ( ( 1, 4 ), Wall )
        , ( ( 1, 5 ), Wall )
        ]



-- INITIAL MODEL


initialModel : Model
initialModel =
    { statusMsg = ""
    , world = []
    , settings = initialSettings
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        GotTextInput inputTxt ->
            ( { model | statusMsg = inputTxt }, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Type something ✌️", onInput GotTextInput ] []
        , br [] []
        , p [] [ text model.statusMsg ]
        ]
