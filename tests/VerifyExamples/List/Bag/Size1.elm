module VerifyExamples.List.Bag.Size1 exposing (..)

-- This file got generated by [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples).
-- Please don't modify this file by hand!

import Test
import Expect

import List.Bag exposing (..)







spec1 : Test.Test
spec1 =
    Test.test "#size: \n\n    size []\n    --> 0" <|
        \() ->
            Expect.equal
                (
                size []
                )
                (
                0
                )