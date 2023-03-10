module VerifyExamples.Bag.FromList1 exposing (..)

-- This file got generated by [elm-verify-examples](https://github.com/stoeffel/elm-verify-examples).
-- Please don't modify this file by hand!

import Test
import Expect

import Bag exposing (..)







spec1 : Test.Test
spec1 =
    Test.test "#fromList: \n\n    [ \"🍇\", \"🍎\", \"🍊\" ]\n        |> fromList identity\n        |> toAssociationList\n    --> [(\"🍇\",1),(\"🍊\",1),(\"🍎\",1)]" <|
        \() ->
            Expect.equal
                (
                [ "🍇", "🍎", "🍊" ]
                    |> fromList identity
                    |> toAssociationList
                )
                (
                [("🍇",1),("🍊",1),("🍎",1)]
                )