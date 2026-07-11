module WorldTest exposing (..)

import Expect exposing (..)
import Html exposing (a)
import Main exposing (..)
import Test exposing (..)


testInit : Test
testInit =
    describe "Initializing the program" <|
        [ test "check integer" <|
            \_ -> 1 |> Expect.equal 1
        ]
