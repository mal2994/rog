module RogTest exposing (..)

import Expect exposing (..)
import Html exposing (a)
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
    describe "rendering system"
        [ describe "floors" <|
            [ Test.todo "model has floors"
            , Test.todo "floors display as ."
            ]
        , describe "walls" <|
            [ test "model has walls" <|
                \_ ->
                    initialModel.world
                        |> addWallsLvl1
                        |> List.filter
                            (cellToTile >> eqTile Wall)
                        |> List.length
                        |> Expect.greaterThan 0
            , test "wall tile display as #" <|
                \_ ->
                    toChar Wall
                        |> Expect.equal '#'
            , Test.todo "walls display as #"
            ]
        , describe "player" <|
            [ Test.todo "model has player"
            , Test.todo "player display as @"
            ]
        , describe "view" <|
            [ Test.todo "view exists"
            , Test.todo "view sized according to settings"
            , Test.todo ""
            ]
        ]


testTextInput : Test
testTextInput =
    Test.todo "test command handler"


testTileRules : Test
testTileRules =
    Test.todo "walls prohibit movement"
