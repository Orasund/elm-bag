# elm-bag

Two implementations of a bag using a dict and an association list

    {-| type of List.Bag -}
    type alias Bag a =
        List (a, Int)
    
    {-| type of Bag -}
    type alias Bag comparable a =
        { content : Dict comparable ( a, Int )
        , encode : a -> comparable
        }

# Install

    elm install Orasund/elm-bag

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

# Alternatives

Only alternative so far has been [JohnBugner/elm-bag](JohnBugner/elm-bag), which I used as a clear inspiration to this package. While JohnBugner used a normal dictionary, i used the same approach as the [AnyDict implementation by turboMaCk](https://dark.elm.dmy.fr/packages/turboMaCk/any-dict/latest/).

I want to give credit to both JohnBugner and TurboMaCk for their contribution to the elm community. This package is just the combination of the previous works of both of them.