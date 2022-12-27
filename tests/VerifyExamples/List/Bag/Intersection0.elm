module VerifyExamples.List.Bag.Intersection0 exposing (..)

-- This file got generated by [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples).
-- Please don't modify this file by hand!

import Test
import Expect

import List.Bag exposing (..)







spec0 : Test.Test
spec0 =
    Test.test "#intersection: \n\n    intersection [(\"🍊\",1),(\"🍎\",2),(\"🍇\",3)] [(\"🍇\",1),(\"🍎\",2),(\"🍊\",3)] \n    --> [(\"🍇\",1),(\"🍎\",2),(\"🍊\",1)]" <|
        \() ->
            Expect.equal
                (
                intersection [("🍊",1),("🍎",2),("🍇",3)] [("🍇",1),("🍎",2),("🍊",3)] 
                )
                (
                [("🍇",1),("🍎",2),("🍊",1)]
                )