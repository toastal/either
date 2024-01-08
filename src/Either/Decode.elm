{-
   Copyright © 2018–2021 toastal <toastal@posteo.net> (https://toast.al)

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
-}


module Either.Decode exposing (either)

{-| Provides a <abbr title="JavaScript Object Notation">JSON</abbr>
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
        [ Decode.map Right b
        , Decode.map Left a
        ]
