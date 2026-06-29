module RogTest exposing (..)

import Expect exposing (..)
import Html exposing (a)
import Rog exposing (..)
import Set
import Test exposing (..)


testInit : Test
testInit =
    describe "Initializing the program" <|
        [ test "check integer" <|
            \_ -> 1 |> Expect.equal 1
        , test "check model" <|
            \_ -> initialModel.statusMsg |> Expect.equal ""
        ]


testModel : Test
testModel =
    describe "rendering system"
        [ describe "floors" <|
            [ test "1 x 1 floor" <|
                \_ ->
                    makeFloorGrid 1 1
                        |> Expect.equal
                            (Set.fromList
                                [ ( ( 0, 0 ), '.' ) ]
                            )
            , test "2 x 1 floor" <|
                \_ ->
                    makeFloorGrid 2 1
                        |> Expect.equal
                            (Set.fromList
                                [ ( ( 0, 0 ), '.' )
                                , ( ( 1, 0 ), '.' )
                                ]
                            )
            , test "2 x 2 floor" <|
                \_ ->
                    makeFloorGrid 2 2
                        |> Expect.equal
                            (Set.fromList
                                [ ( ( 0, 0 ), '.' )
                                , ( ( 1, 0 ), '.' )
                                , ( ( 0, 1 ), '.' )
                                , ( ( 1, 1 ), '.' )
                                ]
                            )
            , test "12 x 12 floor" <|
                \_ ->
                    makeFloorGrid 12 12
                        |> Set.size
                        |> Expect.equal 144
            ]
        , describe "walls" <|
            [ test "model has walls" <|
                \_ ->
                    initialModel.world
                        |> addWallsLvl1
                        |> Set.filter
                            (cellToTile >> eqTile Wall)
                        |> Set.size
                        |> Expect.greaterThan 0
            , test "wall tile display as #" <|
                \_ ->
                    toChar Wall
                        |> Expect.equal '#'
            ]
        , describe "player" <|
            [ Test.todo "model has player"

            -- , test "player display as @" <|
            --     \_->
            --         toChar Player
            --             |> Expect.equal '@'
            --     ]
            -- , describe "view" <|
            --     [ Test.todo "view exists"
            --     , Test.todo "view sized according to settings"
            --     , Test.todo ""
            ]
        ]



-- testTextInput : Test
-- testTextInput =
--     Test.todo "test command handler"
-- testTileRules : Test
-- testTileRules =
--     Test.todo "walls prohibit movement"
-- testViews : Test
-- testViews = Test.todo "view the model"
