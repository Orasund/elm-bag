module VerifyExamples.List.Bag.Member0 exposing (..)

-- This file got generated by [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples).
-- Please don't modify this file by hand!

import Test
import Expect

import List.Bag exposing (..)







spec0 : Test.Test
spec0 =
    Test.test "#member: \n\n    member \"🍒\" [ ( \"🍇\", 1 ), ( \"🍎\", 1 ), ( \"🍊\", 1 ) ]\n    --> False" <|
        \() ->
            Expect.equal
                (
                member "🍒" [ ( "🍇", 1 ), ( "🍎", 1 ), ( "🍊", 1 ) ]
                )
                (
                False
                )