module VerifyExamples.Bag.Count0 exposing (..)

-- This file got generated by [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples).
-- Please don't modify this file by hand!

import Test
import Expect

import Bag exposing (..)







spec0 : Test.Test
spec0 =
    Test.test "#count: \n\n    [ ( \"🍊\", 42 ) ]\n        |> fromAssociationList identity\n        |> count \"🍎\"\n    --> 0" <|
        \() ->
            Expect.equal
                (
                [ ( "🍊", 42 ) ]
                    |> fromAssociationList identity
                    |> count "🍎"
                )
                (
                0
                )