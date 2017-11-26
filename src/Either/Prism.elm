module Either.Prism
    exposing
        ( leftp
        , rightp
        )

{-| [elm-monocle](http://package.elm-lang.org/packages/arturopala/elm-monocle/latest)-compatible `Prisms`.

@docs leftp, rightp

-}

import Either exposing (..)


type alias Prism a b =
    { getOption : a -> Maybe b
    , reverseGet : b -> a
    }


{-| `Prism` for the `Left` value. Also known as `_Left` in other languages.

    .getOption leftp (Left 1)       == Just 1
    .getOption leftp (Right "fish") == Nothing
    .reverseGet leftp 2             == Left 2

-}
leftp : Prism (Either a x) a
leftp =
    { getOption = leftToMaybe, reverseGet = Left }


{-| `Prism` for the `Right` value. Also known as `_Right` in other languages.

    .getOption rightp (Left 1)       == Nothing
    .getOption rightp (Right "fish") == Just "fish"
    .reverseGet rightp 2             == Right 2

-}
rightp : Prism (Either x b) b
rightp =
    { getOption = rightToMaybe, reverseGet = Right }
