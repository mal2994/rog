module Main exposing (..)

import Browser
import Html exposing (Html, br, div, input )
import Html.Attributes exposing (placeholder)
import Html.Events exposing (onInput)



-- https://menez.io/css/font/dungeon-mode.ttf
-- @font-face
-- dungeon-mode
-- truetype


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


type alias Model =
    {}



-- INITIAL MODEL


initialModel : Model
initialModel =
    {}


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        GotTextInput t ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "> TYPE COMMAND ☻ :)", onInput GotTextInput ] []
        , br [] []

        -- , p [] [ text (viewWorld model.world) ]
        -- , p [] [ text model.statusMsg ]
        ]
