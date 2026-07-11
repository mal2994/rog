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
        withParsedVerb =
            { interpreter | verb = parse firstChar }

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
                { interpreter | rawText = "TODO", verb = Down }

            else
                { interpreter | rawText = inputStr, verb = None }

        _ ->
            case withParsedVerb.verb of
                None ->
                    initialize

                _ ->
                    { withParsedVerb | rawText = firstChar |> String.fromChar }


initialize : Interpreter
initialize =
    { rawText = "", verb = None }
