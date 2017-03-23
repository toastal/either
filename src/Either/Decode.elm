module Either.Decode
    exposing
        ( either
        )

{-|
Provides a <abbr title="JavaScript Object Notation">JSON</abbr>
[`Decoder`](http://package.elm-lang.org/packages/elm-lang/core/latest/Json-Decode#Decoder)
for the `Either` type.


# Definition
@docs either

-}

import Either exposing (Either(..))
import Json.Decode as Decode exposing (Decoder)


{-| Decode an `Either` from a <abbr title="JavaScript Object Notation">JSON</abbr>
[`Value`](http://package.elm-lang.org/packages/elm-lang/core/latest/Json-Decode#Value).

    decodeString (either string int) "4" == Ok (Right 4)

-}
either : Decoder a -> Decoder b -> Decoder (Either a b)
either a b =
    Decode.oneOf
        [ Decode.map Left a
        , Decode.map Right b
        ]
