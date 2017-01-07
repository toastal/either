module Tests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer)
import Random.Pcg as Random
import Shrink
import Test exposing (Test, describe, fuzz, fuzz2, fuzz3, test)
import Either exposing (..)


either : Fuzzer (a -> Either a a)
either =
    Fuzz.custom (Random.choice Left Right) Shrink.noShrink


all : Test
all =
    describe "Testing Either"
        [ functorBifunctor
        ]


functorBifunctor : Test
functorBifunctor =
    describe "Functor & Bifunctor"
        [ test "Functor Law I: map identity = identity" <|
            \() ->
                let
                    e =
                        singleton ()
                in
                    Expect.equal True <| map identity e == identity e
        , test "Companion to Functor Law I" <|
            \() ->
                let
                    e =
                        Left ()
                in
                    Expect.equal True <| mapLeft identity e == identity e
        , fuzz3 Fuzz.int
            Fuzz.int
            Fuzz.int
            "Functor Law II: map (g << f) = map g << map f"
          <|
            \x y z ->
                let
                    e =
                        singleton x

                    f =
                        (+) y

                    g =
                        (*) z
                in
                    Expect.equal True <| map (g << f) e == (map g << map f) e
        ]
