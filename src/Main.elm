module Main exposing (..)

import Browser
import Html exposing (Html, br, div, input, p, pre, text)
import Html.Attributes exposing (placeholder)
import Html.Events exposing (onInput)
import World exposing (World, viewWorld)



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
    { world : World
    , userTextRaw : String
    }



-- INITIAL MODEL


initialModel : Model
initialModel =
    { world = World.initialWorld 
    , userTextRaw = ""
    }


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
        [ p [] []
        , p [] [ text (viewWorld model.world) ]
        , input [ placeholder "> TYPE COMMAND ☻ :)", onInput GotTextInput ] []

        -- , p [] [ text model.statusMsg ]
        ]
