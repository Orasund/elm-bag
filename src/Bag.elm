module Bag exposing (..)

import Dict exposing (Dict)
import Html exposing (a)


type alias Bag comparable a =
    { content : Dict comparable ( a, Int )
    , encode : a -> comparable
    }


{-| Construct an empty bag

    empty identity |> toAssociationList --> []

-}
empty : (a -> comparable) -> Bag comparable a
empty encode =
    { content = Dict.empty, encode = encode }


{-| Construct a bag with a single element

    singleton identity "🍎" |> toAssociationList --> [ ( "🍎", 1 ) ]

-}
singleton : (a -> comparable) -> a -> Bag comparable a
singleton encode a =
    { content = Dict.singleton (encode a) ( a, 1 )
    , encode = encode
    }


{-| Check if the bag is empty

    empty identity
        |> isEmpty
        --> True

    singleton identity "🍎"
        |> isEmpty
        --> False

-}
isEmpty : Bag comparable a -> Bool
isEmpty bag =
    Dict.isEmpty bag.content


{-| Insert an element into the bag

    empty identity
        |> insert 1 "🍎"
        |> toAssociationList
        --> [("🍎",1)]

.

    [ ( "🍊", 1 ), ( "🍎", 1 ), ( "🍇", 1 ) ]
        |> fromAssociationList identity
        |> insert 2 "🍎"
        |> toAssociationList
        --> [("🍇",1),("🍊",1),("🍎",3)]

.

    [ ( "🍊", 1 ), ( "🍇", 1 ) ]
        |> fromAssociationList identity
        |> insert 1 "🍎"
        |> toAssociationList
        --> [("🍇",1),("🍊",1),("🍎",1)]

-}
insert : Int -> a -> Bag comparable a -> Bag comparable a
insert n a bag =
    { bag
        | content =
            bag.content
                |> Dict.update (bag.encode a)
                    (\maybe ->
                        maybe
                            |> Maybe.map (Tuple.mapSecond ((+) n))
                            |> Maybe.withDefault ( a, n )
                            |> Just
                    )
    }


{-| Count the amounts of an element in the bag

    empty identity
        |> count "🍎"
        --> 0

.

    [ ( "🍎", 42 ) ]
        |> fromAssociationList identity
        |> count "🍎"
        --> 42

.

    [ ( "🍊", 42 ) ]
        |> fromAssociationList identity
        |> count "🍎"
        --> 0

-}
count : a -> Bag comparable a -> Int
count a bag =
    bag.content
        |> Dict.get (bag.encode a)
        |> Maybe.map Tuple.second
        |> Maybe.withDefault 0


{-| Remove an element from the bag

    empty identity
        |> remove 1 "🍎"
        |> toAssociationList
        --> []

.

    [ ( "🍊", 1 ), ( "🍎", 2 ), ( "🍇", 1 ) ]
        |> fromAssociationList identity
        |> remove 1 "🍎"
        |> toAssociationList
        --> [("🍇",1),("🍊",1),("🍎",1)]

.

    [ ( "🍊", 1 ), ( "🍇", 1 ) ]
        |> fromAssociationList identity
        |> remove 1 "🍎"
        |> toAssociationList
        --> [("🍇",1),("🍊",1)]

.

    [ ( "🍊", 1 ), ( "🍎", 1 ), ( "🍇", 1 ) ]
        |> fromAssociationList identity
        |> remove 1 "🍎"
        |> toAssociationList
        --> [("🍇",1),("🍊",1)]

-}
remove : Int -> a -> Bag comparable a -> Bag comparable a
remove n a bag =
    { bag
        | content =
            bag.content
                |> Dict.update (bag.encode a)
                    (\maybe ->
                        maybe
                            |> Maybe.andThen
                                (\( a0, n0 ) ->
                                    if n0 > n then
                                        Just ( a0, n0 - n )

                                    else
                                        Nothing
                                )
                    )
    }


{-| Convert into an association list
-}
toAssociationList : Bag comparable a -> List ( a, Int )
toAssociationList bag =
    bag.content
        |> Dict.values


{-| Construct from an association list
-}
fromAssociationList : (a -> comparable) -> List ( a, Int ) -> Bag comparable a
fromAssociationList encode list =
    { content =
        list
            |> List.map (\( a, n ) -> ( encode a, ( a, n ) ))
            |> Dict.fromList
    , encode = encode
    }


{-| Convert into a list with repeating elements

    empty identity
        |> toList
         --> []

.

    [ ( "🍎", 2 ) ]
        |> fromAssociationList identity
        |> toList
        --> ["🍎","🍎"]

.

    [ ( "🍊", 1 ), ( "🍎", 2 ), ( "🍇", 1 ) ]
        |> fromAssociationList identity
        |> toList
        --> ["🍇","🍊","🍎","🍎"]

-}
toList : Bag comparable a -> List a
toList bag =
    bag.content
        |> Dict.values
        |> List.concatMap (\( a, n ) -> List.repeat n a)


{-| Counts the occurrences of elements in a bag.

    []
        |> fromList identity
        |> toAssociationList
        --> []

.

    [ "🍎", "🍎" ]
        |> fromList identity
        |> toAssociationList
        --> [("🍎",2)]

.

    [ "🍇", "🍎", "🍊" ]
        |> fromList identity
        |> toAssociationList
        --> [("🍇",1),("🍊",1),("🍎",1)]

.

    [ "🍇", "🍎", "🍊", "🍎", "🍊", "🍎" ]
        |> fromList identity
        |> toAssociationList
        --> [("🍇",1),("🍊",2),("🍎",3)]

-}
fromList : (a -> comparable) -> List a -> Bag comparable a
fromList encode =
    List.foldl (insert 1) (empty encode)


{-| Combine two bags.

    [ ( "🍇", 1 ), ( "🍊", 1 ) ]
        |> fromAssociationList identity
        |> plus (
            [ ( "🍒", 1 ), ( "🍎", 1 ) ]
                |> fromAssociationList identity
        )
        |> toAssociationList
        --> [("🍇",1),("🍊",1),("🍎",1),("🍒",1)]

.

    [ ( "🍇", 1 ), ( "🍎", 1 ), ( "🍊", 1 ) ]
        |> fromAssociationList identity
        |> plus (singleton identity "🍎")
        |> toAssociationList
        --> [("🍇",1),("🍊",1),("🍎",2)]

.

    [ ( "🍇", 1 ), ( "🍎", 1 ), ( "🍊", 1 ) ]
        |> fromAssociationList identity
        |> plus (
            [ ( "🍎", 1 ), ( "🍒", 1 ) ]
                |> fromAssociationList identity
        )
        |> toAssociationList
        --> [("🍇",1),("🍊",1),("🍎",2),("🍒",1)]

-}
plus : Bag comparable a -> Bag comparable a -> Bag comparable a
plus b1 b2 =
    b1.content
        |> Dict.foldl
            (\_ ( a, n0 ) ->
                insert n0 a
            )
            b2


{-| subtracts the first bag from the second.

    [ ( "🍇", 1 ), ( "🍎", 1 ), ( "🍊", 1 ) ]
        |> fromAssociationList identity
        |> minus (empty identity)
        |> toAssociationList
        --> [("🍇",1),("🍊",1),("🍎",1)]

.

    empty identity
        |> minus (
            [ ( "🍇", 1 ), ( "🍎", 1 ), ( "🍊", 1 ) ]
                |> fromAssociationList identity
        )
        |> toAssociationList
        --> []

.

    [ ( "🍇", 2 ), ( "🍎", 2 ), ( "🍊", 2 ) ]
        |> fromAssociationList identity
        |> minus (
            [ ( "🍎", 2 ), ( "🍊", 1 ) ]
                |> fromAssociationList identity
        )
        |> toAssociationList
        --> [("🍇",2),("🍊",1)]

-}
minus : Bag comparable a -> Bag comparable a -> Bag comparable a
minus b1 b2 =
    b1.content
        |> Dict.foldl
            (\_ ( a, n0 ) ->
                remove n0 a
            )
            b2


{-| Intersect two bags.

    [ ( "🍇", 1 ), ( "🍎", 1 ), ( "🍊", 1 ) ]
        |> fromAssociationList identity
        |> intersection (empty identity)
        |> toAssociationList
        --> []

.

    empty identity
        |> intersection (
            [ ( "🍇", 1 ), ( "🍎", 1 ), ( "🍊", 1 ) ]
                |> fromAssociationList identity
        )
        |> toAssociationList
        --> []

.

    [ ( "🍎", 1 ), ( "🍊", 1 ) ]
        |> fromAssociationList identity
        |> intersection (
            [ ( "🍇", 1 ), ( "🍎", 1 ) ]
                |> fromAssociationList identity
        )
        |> toAssociationList
        --> [("🍎",1)]

.

    [ ( "🍇", 1 ), ( "🍎", 2 ), ( "🍊", 3 ) ]
        |> fromAssociationList identity
        |> intersection (
            [ ( "🍊", 1 ), ( "🍎", 2 ), ( "🍇", 3 ) ]
                |> fromAssociationList identity
        )
        |> toAssociationList
        --> [("🍇",1),("🍊",1),("🍎",2)]

-}
intersection : Bag comparable a -> Bag comparable a -> Bag comparable a
intersection b1 b2 =
    { content =
        Dict.merge (\_ _ -> identity)
            (\k ( _, n1 ) ( a, n2 ) ->
                Dict.insert k ( a, min n1 n2 )
            )
            (\_ _ -> identity)
            b1.content
            b2.content
            Dict.empty
    , encode = b2.encode
    }


{-| Compute if the element is a member

    member "🍎" (empty identity) --> False

.

    [ ( "🍇", 1 ), ( "🍎", 1 ), ( "🍊", 1 ) ]
        |> fromAssociationList identity
        |> member "🍎"
        --> True

.

    [ ( "🍇", 1 ), ( "🍎", 1 ), ( "🍊", 1 ) ]
        |> fromAssociationList identity
        |> member "🍒"
        --> False

-}
member : a -> Bag comparable a -> Bool
member a bag =
    bag.content |> Dict.member (bag.encode a)


{-| Counts all elements in the bag

    size (empty identity) --> 0

.

    [ ( "🍇", 1 ), ( "🍎", 2 ), ( "🍊", 3 ) ]
        |> fromAssociationList identity
        |> size
        --> 6

-}
size : Bag comparable a -> Int
size bag =
    bag.content
        |> Dict.values
        |> List.map Tuple.second
        |> List.sum
