module VerifyExamples.Bag.Minus2 exposing (..)

-- This file got generated by [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples).
-- Please don't modify this file by hand!

import Test
import Expect

import Bag exposing (..)







spec2 : Test.Test
spec2 =
    Test.test "#minus: \n\n    [ ( \"🍇\", 1 ), ( \"🍎\", 1 ), ( \"🍊\", 1 ) ]\n        |> fromAssociationList identity\n        |> minus (empty identity)\n        |> toAssociationList\n    --> [(\"🍇\",1),(\"🍊\",1),(\"🍎\",1)]" <|
        \() ->
            Expect.equal
                (
                [ ( "🍇", 1 ), ( "🍎", 1 ), ( "🍊", 1 ) ]
                    |> fromAssociationList identity
                    |> minus (empty identity)
                    |> toAssociationList
                )
                (
                [("🍇",1),("🍊",1),("🍎",1)]
                )