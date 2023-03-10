module VerifyExamples.Bag.ToList1 exposing (..)

-- This file got generated by [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples).
-- Please don't modify this file by hand!

import Test
import Expect

import Bag exposing (..)







spec1 : Test.Test
spec1 =
    Test.test "#toList: \n\n    [ ( \"🍎\", 2 ) ]\n        |> fromAssociationList identity\n        |> toList\n    --> [\"🍎\",\"🍎\"]" <|
        \() ->
            Expect.equal
                (
                [ ( "🍎", 2 ) ]
                    |> fromAssociationList identity
                    |> toList
                )
                (
                ["🍎","🍎"]
                )