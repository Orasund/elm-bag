module VerifyExamples.List.Bag.Insert2 exposing (..)

-- This file got generated by [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples).
-- Please don't modify this file by hand!

import Test
import Expect

import List.Bag exposing (..)







spec2 : Test.Test
spec2 =
    Test.test "#insert: \n\n    insert 1 \"🍎\" []\n    --> [(\"🍎\",1)]" <|
        \() ->
            Expect.equal
                (
                insert 1 "🍎" []
                )
                (
                [("🍎",1)]
                )