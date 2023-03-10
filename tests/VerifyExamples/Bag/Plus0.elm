module VerifyExamples.Bag.Plus0 exposing (..)

-- This file got generated by [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples).
-- Please don't modify this file by hand!

import Test
import Expect

import Bag exposing (..)







spec0 : Test.Test
spec0 =
    Test.test "#plus: \n\n    [ ( \"🍇\", 1 ), ( \"🍎\", 1 ), ( \"🍊\", 1 ) ]\n        |> fromAssociationList identity\n        |> plus (\n            [ ( \"🍎\", 1 ), ( \"🍒\", 1 ) ]\n                |> fromAssociationList identity\n        )\n        |> toAssociationList\n    --> [(\"🍇\",1),(\"🍊\",1),(\"🍎\",2),(\"🍒\",1)]" <|
        \() ->
            Expect.equal
                (
                [ ( "🍇", 1 ), ( "🍎", 1 ), ( "🍊", 1 ) ]
                    |> fromAssociationList identity
                    |> plus (
                        [ ( "🍎", 1 ), ( "🍒", 1 ) ]
                            |> fromAssociationList identity
                    )
                    |> toAssociationList
                )
                (
                [("🍇",1),("🍊",1),("🍎",2),("🍒",1)]
                )