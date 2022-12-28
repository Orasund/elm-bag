module VerifyExamples.List.Bag.Plus0 exposing (..)

-- This file got generated by [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples).
-- Please don't modify this file by hand!

import Test
import Expect

import List.Bag exposing (..)







spec0 : Test.Test
spec0 =
    Test.test "#plus: \n\n    plus [ ( \"🍎\", 1 ), ( \"🍒\", 1 ) ] [ ( \"🍇\", 1 ), ( \"🍎\", 1 ), ( \"🍊\", 1 ) ]\n    --> [(\"🍇\",1),(\"🍎\",2),(\"🍊\",1),(\"🍒\",1)]" <|
        \() ->
            Expect.equal
                (
                plus [ ( "🍎", 1 ), ( "🍒", 1 ) ] [ ( "🍇", 1 ), ( "🍎", 1 ), ( "🍊", 1 ) ]
                )
                (
                [("🍇",1),("🍎",2),("🍊",1),("🍒",1)]
                )