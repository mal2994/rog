module MainTest exposing (..)

import Expect exposing (..)
import Main exposing (..)
import Test exposing (..)


testInit : Test
testInit =
    describe "Initializing the program" <|
        [ test "check integer" <|
            \_ -> 1 |> Expect.equal 1
        , Test.todo "updatePlayer should not be hardcoded"]

