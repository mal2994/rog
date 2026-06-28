module Rog exposing (..)

import Browser
import Html exposing (Html, br, div, p, text, textarea)
import Html.Attributes exposing (placeholder)


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


type alias Model =
    { statusMsg : String }


initialModel : Model
initialModel =
    { statusMsg = "Hello there!" }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ textarea [ placeholder "Type something..." ] []
        , br [] []
        , p [] [ text model.statusMsg ]
        ]
