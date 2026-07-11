module Interpreter exposing (..)


type alias Interpreter =
    { rawText : String
    , verb : Verb
    }


type Verb
    = Left
    | Right
    | Up
    | Down
    | X
    | Z
    | None


parse : Char -> Verb
parse a =
    case Char.toLower a of
        ' ' ->
            None

        'a' ->
            Left

        's' ->
            Down

        'd' ->
            Right

        'w' ->
            Up

        'z' ->
            Z

        'x' ->
            X

        _ ->
            None


{-| call this last in ur pipeline
-}
get : Interpreter -> Verb
get x =
    x.verb


runInterpreter : Interpreter -> String -> Interpreter
runInterpreter interpreter inputStr =
    let
        withUpdatedString =
            { interpreter | rawText = inputStr }

        handleBlank x =
            Maybe.withDefault ( ' ', "" ) x

        firstChar =
            inputStr
                |> String.uncons
                |> handleBlank
                |> Tuple.first
    in
    case firstChar of
        '>' ->
            if String.endsWith "\n" inputStr then
                { withUpdatedString | rawText = "TODO", verb = None }

            else
                { withUpdatedString | verb = None }

        _ ->
            { withUpdatedString | verb = parse firstChar }


initialize : Interpreter
initialize =
    { rawText = "", verb = None }
