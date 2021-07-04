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


module Either.Prism exposing (Prism, leftp, rightp)

{-| [elm-monocle](http://package.elm-lang.org/packages/arturopala/elm-monocle/latest)-compatible `Prism`s.

@docs Prism, leftp, rightp

-}

import Either exposing (..)


{-| Constructor
-}
type alias Prism a b =
    { getOption : a -> Maybe b
    , reverseGet : b -> a
    }


{-| `Prism` for the `Left` value. Also known as `_Left` in other languages.

    .getOption leftp (Left 1) == Just 1

    .getOption leftp (Right "fish") == Nothing

    .reverseGet leftp 2 == Left 2

-}
leftp : Prism (Either a x) a
leftp =
    { getOption = leftToMaybe, reverseGet = Left }


{-| `Prism` for the `Right` value. Also known as `_Right` in other languages.

    .getOption rightp (Left 1) == Nothing

    .getOption rightp (Right "fish") == Just "fish"

    .reverseGet rightp "phish" == Right "phish"

-}
rightp : Prism (Either x b) b
rightp =
    { getOption = rightToMaybe, reverseGet = Right }
