module Interpreter exposing (..)

import Maybe exposing (withDefault)


type alias Interpreter =
    { rawText : String
    , verb : Verb
    , previousVerbText : Maybe String
    }


type Verb
    = Left
    | Right
    | Up
    | Down
    | X
    | Z
    | None
    | Run String


toString : Verb -> String
toString x =
    case x of
        Left ->
            "⬅"

        Right ->
            "➡"

        Up ->
            "⬆"

        Down ->
            "⬇"

        X ->
            "X"

        Z ->
            "Z"

        None ->
            ""

        Run y ->
            ""


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

        runTuple =
            inputStr |> String.uncons |> handleBlank

        firstChar =
            runTuple |> Tuple.first

        restFirstChar =
            runTuple |> Tuple.second
    in
    case firstChar of
        '>' ->
            if String.endsWith "." inputStr then
                { interpreter
                    | rawText = ""
                    , verb = Run restFirstChar
                    , previousVerbText = ">" ++ restFirstChar |> Just
                }

            else
                { interpreter | rawText = inputStr, verb = None }

        _ ->
            case withParsedVerb.verb of
                None ->
                    { initialize | previousVerbText = interpreter.previousVerbText }

                _ ->
                    { withParsedVerb | rawText = "", previousVerbText = toString withParsedVerb.verb |> Just }


initialize : Interpreter
initialize =
    { rawText = "", verb = None, previousVerbText = Nothing }
