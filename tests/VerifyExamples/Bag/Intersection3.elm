module VerifyExamples.Bag.Intersection3 exposing (..)

-- This file got generated by [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples).
-- Please don't modify this file by hand!

import Test
import Expect

import Bag exposing (..)







spec3 : Test.Test
spec3 =
    Test.test "#intersection: \n\n    [ ( \"🍇\", 1 ), ( \"🍎\", 1 ), ( \"🍊\", 1 ) ]\n        |> fromAssociationList identity\n        |> intersection (empty identity)\n        |> toAssociationList\n    --> []" <|
        \() ->
            Expect.equal
                (
                [ ( "🍇", 1 ), ( "🍎", 1 ), ( "🍊", 1 ) ]
                    |> fromAssociationList identity
                    |> intersection (empty identity)
                    |> toAssociationList
                )
                (
                []
                )