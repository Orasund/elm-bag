module VerifyExamples.Bag.Member0 exposing (..)

-- This file got generated by [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples).
-- Please don't modify this file by hand!

import Test
import Expect

import Bag exposing (..)







spec0 : Test.Test
spec0 =
    Test.test "#member: \n\n    [ ( \"🍇\", 1 ), ( \"🍎\", 1 ), ( \"🍊\", 1 ) ]\n        |> fromAssociationList identity\n        |> member \"🍒\"\n    --> False" <|
        \() ->
            Expect.equal
                (
                [ ( "🍇", 1 ), ( "🍎", 1 ), ( "🍊", 1 ) ]
                    |> fromAssociationList identity
                    |> member "🍒"
                )
                (
                False
                )