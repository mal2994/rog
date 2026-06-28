module Rog exposing (..)

import Browser
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


type Msg
    = NoOp
    | GotTextInput String


type alias Model =
    { walls : List ( Int, Int )
    , statusMsg : String
    }


initialModel : Model
initialModel =
    { statusMsg = "", walls = [] }


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
