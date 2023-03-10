module VerifyExamples.Bag.Size0 exposing (..)

-- This file got generated by [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples).
-- Please don't modify this file by hand!

import Test
import Expect

import Bag exposing (..)







spec0 : Test.Test
spec0 =
    Test.test "#size: \n\n    [ ( \"🍇\", 1 ), ( \"🍎\", 2 ), ( \"🍊\", 3 ) ]\n        |> fromAssociationList identity\n        |> size\n    --> 6" <|
        \() ->
            Expect.equal
                (
                [ ( "🍇", 1 ), ( "🍎", 2 ), ( "🍊", 3 ) ]
                    |> fromAssociationList identity
                    |> size
                )
                (
                6
                )