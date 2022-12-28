module Main exposing (main)

import Bag
import Benchmark exposing (..)
import Benchmark.Runner exposing (BenchmarkProgram, program)
import List.Bag


main : BenchmarkProgram
main =
    program suite


suite : Benchmark
suite =
    let
        newListBag n =
            List.range 0 (n - 1)
                |> List.map String.fromInt
                |> List.Bag.fromList

        newBag n =
            List.range 0 (n - 1)
                |> List.map String.fromInt
                |> Bag.fromList

        ranges =
            [ 3, 5, 10 ]
    in
    [ ranges
        |> List.map
            (\n ->
                describe ("Using " ++ String.fromInt n ++ " keys")
                    [ benchmark "List.Bag" <|
                        \_ -> List.Bag.insert 1 "new" (newListBag n)
                    , benchmark "Bag" <|
                        \_ -> Bag.insert 1 "new" (newBag n)
                    ]
            )
        |> describe "insert a new key"
    , ranges
        |> List.map
            (\n ->
                describe ("Using " ++ String.fromInt n ++ " keys")
                    [ benchmark "List.Bag" <|
                        \_ -> List.Bag.insert 1 (String.fromInt (n - 1)) (newListBag n)
                    , benchmark "Bag" <|
                        \_ -> Bag.insert 1 (String.fromInt (n - 1)) (newBag n)
                    ]
            )
        |> describe "insert an existing key (worst case)"
    , ranges
        |> List.map
            (\n ->
                describe ("Using " ++ String.fromInt n ++ " keys")
                    [ benchmark "List.Bag" <|
                        \_ -> List.Bag.insert 1 ("0") (newListBag n)
                    , benchmark "Bag" <|
                        \_ -> Bag.insert 1 ("0") (newBag n)
                    ]
            )
        |> describe "insert an existing key (best case)"
    , ranges
        |> List.map
            (\n ->
                describe ("Using " ++ String.fromInt n ++ " keys")
                    [ benchmark "List.Bag" <|
                        \_ -> List.Bag.count "new" (newListBag n)
                    , benchmark "Bag" <|
                        \_ -> Bag.count "new" (newBag n)
                    ]
            )
        |> describe "counting non existing key"
    , ranges
        |> List.map
            (\n ->
                describe ("Using " ++ String.fromInt n ++ " keys")
                    [ benchmark "List.Bag" <|
                        \_ -> List.Bag.count (String.fromInt (n - 1)) (newListBag n)
                    , benchmark "Bag" <|
                        \_ -> Bag.count (String.fromInt (n - 1)) (newBag n)
                    ]
            )
        |> describe "counting existing key (worst case)"
    , ranges
        |> List.map
            (\n ->
                describe ("Using " ++ String.fromInt n ++ " keys")
                    [ benchmark "List.Bag" <|
                        \_ -> List.Bag.count ("0") (newListBag n)
                    , benchmark "Bag" <|
                        \_ -> Bag.count ("0") (newBag n)
                    ]
            )
        |> describe "counting existing key (best case)"
    ]
        |> describe "Comparing List.Bag with Bag"
