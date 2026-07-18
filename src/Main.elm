module Main exposing (..)

import Browser
import Entity exposing (Direction(..))
import Html exposing (Html, div, input, p, text)
import Html.Attributes exposing (autofocus, id, placeholder, value)
import Html.Events exposing (onInput)
import Interpreter exposing (Interpreter, runInterpreter)
import World exposing (World, updatePlayer, viewWorld)
import Html.Attributes exposing (autocomplete)
import Html.Attributes exposing (spellcheck)
import Html.Attributes exposing (lang)



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
    , interpreter : Interpreter
    , messages : List String
    }



-- INITIAL MODEL


initialModel : Model
initialModel =
    { world = World.initialWorld
    , interpreter = Interpreter.initialize
    , messages = []
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        GotTextInput t ->
            let
                interpreterUpdated =
                    runInterpreter model.interpreter t

                withInterpreterUpdated =
                    { model | interpreter = interpreterUpdated }

                withPlayerUpdated =
                    { withInterpreterUpdated | world = updatePlayer model.world interpreterUpdated.verb }
            in
            ( withPlayerUpdated
            , Cmd.none
            )


view : Model -> Html Msg
view model =
    div []
        [ p [ id "world-paragraph" ] [ text (viewWorld model.world) ]
        , input
            [ id "interpreter-input"
            , autofocus True
            , autocomplete False
            , spellcheck False
            , lang "en"
            , placeholder
                (model.interpreter.previousVerbText
                    |> Maybe.withDefault "> TYPE COMMAND ☻ :)"
                )
            , onInput GotTextInput
            , value <| model.interpreter.rawText
            ]
            []

        -- , p [] [ text model.statusMsg ]
        ]
