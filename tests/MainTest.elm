module MainTest exposing (..)

import Expect exposing (..)
import Main exposing (..)
import Test exposing (..)


testInit : Test
testInit =
    describe "Initializing the program" <|
        [ test "check integer" <|
            \_ -> 1 |> Expect.equal 1
        , Test.todo "updatePlayer should not be hardcoded"
        , Test.todo "update model should not be hardcoded to move"
        , Test.todo "verb to direction should return Maybe"
        ]
