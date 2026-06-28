module RogTest exposing (..)

import Expect exposing (..)
import Rog exposing (..)
import Test exposing (..)


testInit : Test
testInit =
    describe "Initializing the program" <|
        [ test "check integer" <|
            \_ -> 1 |> Expect.equal 1
        , test "check model" <|
            \_ -> initialModel.statusMsg |> Expect.equal ""
        ]


testRender : Test
testRender =
    describe "walls" <|
        [ test "initial model has walls" <|
            \_ ->
                initialModel.walls
                    |> List.length
                    |> Expect.greaterThan 0
        , test "walls display as #" <|
            \_ -> False
        , test "lol"
        , test "test"
        ]
