# elm-list-as-bag

Two implementations of a bag using a dict and an association list

    {-| type of List.Bag -}
    type alias Bag a =
        List (a, Int)
    
    {-| type of Bag -}
    type alias Bag comparable a =
        { content : Dict comparable ( a, Int )
        , encode : a -> comparable
        }

# Usage

You should use the list implementation if

* Your keys are not comparable
* You expect to only have a small amount of keys (< 10)
* The order you insert elements should be preserved (the first item you put into your shopping cart should stay the first item in the list)
* You need to compare two bags
* Performance is not an issue

else use the dict implementation

# Performance

I did a few performance test and can say that the list implementation always behaved worse then using a dict.

For a smaller amount of keys the different is however not noticeable (at around 50 keys the association list needs roughly double the amount of time to insert or count elements compared to a dict.)

I would assume that for <10 keys you will not notice a difference.

# Install

    elm install Orasund/elm-bag