module VerifyExamples.Bag.Count1 exposing (..)

-- This file got generated by [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples).
-- Please don't modify this file by hand!

import Test
import Expect

import Bag exposing (..)







spec1 : Test.Test
spec1 =
    Test.test "#count: \n\n    [ ( \"🍎\", 42 ) ]\n        |> fromAssociationList identity\n        |> count \"🍎\"\n    --> 42" <|
        \() ->
            Expect.equal
                (
                [ ( "🍎", 42 ) ]
                    |> fromAssociationList identity
                    |> count "🍎"
                )
                (
                42
                )