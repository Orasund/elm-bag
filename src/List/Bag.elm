module List.Bag exposing
    ( count, empty, singleton
    , insert, remove, plus, minus, intersection
    , isEmpty, member, size
    , fromList, toList
    )

{-| Use an association list as a bag


# Constructor

@docs count, empty, singleton


# Operations

@docs insert, remove, plus, minus, intersection


# Methods

@docs isEmpty, member, size


# Conversion

@docs fromList, toList

-}


{-| Construct an empty list

    empty --> []

-}
empty : List ( a, Int )
empty =
    []


{-| Construct a list with a single element

    singleton "🍎" --> [ ( "🍎", 1 ) ]

-}
singleton : a -> List ( a, Int )
singleton a =
    [ ( a, 1 ) ]


{-| Check if the list is empty

    isEmpty [] --> True

    isEmpty [ ( "🍎", 42 ) ] --> False

-}
isEmpty : List ( a, Int ) -> Bool
isEmpty =
    List.isEmpty


{-| Insert an element into the list

    insert 1 "🍎" [] --> [("🍎",1)]

    insert 2 "🍎" [ ( "🍊", 1 ), ( "🍎", 1 ), ( "🍇", 1 ) ] --> [("🍊",1),("🍎",3),("🍇",1)]

    insert 1 "🍎" [ ( "🍊", 1 ), ( "🍇", 1 ) ] --> [("🍎",1),("🍊",1),("🍇",1)]

-}
insert : Int -> a -> List ( a, Int ) -> List ( a, Int )
insert n a list =
    let
        rec input output =
            case input of
                ( a1, n1 ) :: tail ->
                    if a1 == a then
                        List.reverse output ++ (( a1, n1 + n ) :: tail)

                    else
                        rec tail (( a1, n1 ) :: output)

                [] ->
                    ( a, n ) :: List.reverse output
    in
    rec list []


{-| Count the amounts of an element in the list

    count "🍎" [] --> 0

    count "🍎" [ ( "🍎", 42 ) ] --> 42

    count "🍎" [ ( "🍊", 42 ) ] --> 0

-}
count : a -> List ( a, Int ) -> Int
count a list =
    let
        rec input =
            case input of
                ( a1, n1 ) :: tail ->
                    if a1 == a then
                        n1

                    else
                        rec tail

                [] ->
                    0
    in
    rec list


{-| Remove an element from the list

    remove 1 "🍎" [] --> []

    remove 1 "🍎" [ ( "🍊", 1 ), ( "🍎", 2 ), ( "🍇", 1 ) ] --> [("🍊",1),("🍎",1),("🍇",1)]

    remove 1 "🍎" [ ( "🍊", 1 ), ( "🍇", 1 ) ] --> [("🍊",1),("🍇",1)]

    remove 1 "🍎" [ ( "🍊", 1 ), ( "🍎", 1 ), ( "🍇", 1 ) ] --> [("🍊",1),("🍇",1)]

-}
remove : Int -> a -> List ( a, Int ) -> List ( a, Int )
remove n a list =
    let
        rec input output =
            case input of
                ( a1, n1 ) :: tail ->
                    if a == a1 then
                        if n1 > n then
                            List.reverse output ++ ( a1, n1 - n ) :: tail

                        else
                            List.reverse output ++ tail

                    else
                        rec tail (( a1, n1 ) :: output)

                [] ->
                    List.reverse output
    in
    rec list []


{-| Convert into a list with repeating elements

    toList [] --> []

    toList [ ( "🍎", 2 ) ] --> ["🍎","🍎"]

    toList [ ( "🍊", 1 ), ( "🍎", 2 ), ( "🍇", 1 ) ] --> ["🍊","🍎","🍎","🍇"]

-}
toList : List ( a, Int ) -> List a
toList =
    List.concatMap (\( a, n ) -> List.repeat n a)


{-| Counts the occurrences of elements in a list.

    fromList [] --> []

    fromList [ "🍎", "🍎" ] --> [("🍎",2)]

    fromList [ "🍇", "🍎", "🍊" ] --> [("🍇",1),("🍎",1),("🍊",1)]

    fromList [ "🍇", "🍎", "🍊", "🍎", "🍊", "🍎" ] --> [("🍇",1),("🍎",3),("🍊",2)]

-}
fromList : List a -> List ( a, Int )
fromList list =
    list
        |> List.foldl (\a -> insert 1 a) []
        |> List.reverse


{-| Combine two lists. The order of the second list gets preserved.

    plus [ ( "🍒", 1 ), ( "🍎", 1 ) ] [ ( "🍇", 1 ), ( "🍊", 1 ) ] --> [("🍇",1),("🍊",1),("🍒",1),("🍎",1)]

    plus [ ( "🍎", 1 ) ] [ ( "🍇", 1 ), ( "🍎", 1 ), ( "🍊", 1 ) ] --> [("🍇",1),("🍎",2),("🍊",1)]

    plus [ ( "🍎", 1 ), ( "🍒", 1 ) ] [ ( "🍇", 1 ), ( "🍎", 1 ), ( "🍊", 1 ) ] --> [("🍇",1),("🍎",2),("🍊",1),("🍒",1)]

-}
plus : List ( a, Int ) -> List ( a, Int ) -> List ( a, Int )
plus l1 l2 =
    l1
        |> List.foldl (\( a, n ) -> insert n a) (List.reverse l2)
        |> List.reverse


{-| subtracts the first list from the second.

    minus [] [ ( "🍇", 1 ), ( "🍎", 1 ), ( "🍊", 1 ) ] --> [("🍇",1),("🍎",1),("🍊",1)]

    minus [ ( "🍇", 1 ), ( "🍎", 1 ), ( "🍊", 1 ) ] [] --> []

    minus [ ( "🍎", 2 ), ( "🍊", 1 ) ] [ ( "🍇", 2 ), ( "🍎", 2 ), ( "🍊", 2 ) ] --> [("🍇",2),("🍊",1)]

-}
minus : List ( a, Int ) -> List ( a, Int ) -> List ( a, Int )
minus l1 l2 =
    l1
        |> List.foldl (\( a, n ) -> remove n a) (List.reverse l2)
        |> List.reverse


{-| Intersect two lists. The order of the second list gets preserved.

    intersection [] [ ( "🍇", 1 ), ( "🍎", 1 ), ( "🍊", 1 ) ] --> []

    intersection [ ( "🍇", 1 ), ( "🍎", 1 ), ( "🍊", 1 ) ] [] --> []

    intersection [ ( "🍇", 1 ), ( "🍎", 1 ) ] [ ( "🍎", 1 ), ( "🍊", 1 ) ] --> [("🍎",1)]

    intersection [ ( "🍊", 1 ), ( "🍎", 2 ), ( "🍇", 3 ) ] [ ( "🍇", 1 ), ( "🍎", 2 ), ( "🍊", 3 ) ] --> [("🍇",1),("🍎",2),("🍊",1)]

-}
intersection : List ( a, Int ) -> List ( a, Int ) -> List ( a, Int )
intersection l1 l2 =
    minus (minus l1 l2) l2


{-| Compute if the element is a member

    member "🍎" [] --> False

    member "🍎" [ ( "🍇", 1 ), ( "🍎", 1 ), ( "🍊", 1 ) ] --> True

    member "🍒" [ ( "🍇", 1 ), ( "🍎", 1 ), ( "🍊", 1 ) ] --> False

-}
member : a -> List ( a, Int ) -> Bool
member a =
    List.any (\( a1, _ ) -> a == a1)


{-| Counts all elements in the list

    size [] --> 0

    size [ ( "🍇", 1 ), ( "🍎", 2 ), ( "🍊", 3 ) ] --> 6

-}
size : List ( a, Int ) -> Int
size list =
    list |> List.map Tuple.second |> List.sum
