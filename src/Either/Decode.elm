module Either.Decode
    exposing
        ( either
        )

{-|
Provides a Json decoder for the `Either` type.


# Definition
@docs either

-}

import Either exposing (Either(..))
import Json.Decode as Json exposing (Decoder)


{-| Decode an `Either` from a JSON Value.

    decodeString (either string int) "4" == Ok (Right 4)

-}
either : Decoder a -> Decoder b -> Decoder (Either a b)
either a b =
    Json.oneOf
        [ Json.map Left a
        , Json.map Right b
        ]
