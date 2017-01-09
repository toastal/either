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
        [ functor
        , applicative
        ]


functor : Test
functor =
    describe "Functor"
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
        , fuzz3 Fuzz.int
            Fuzz.int
            Fuzz.int
            "Companion to Law II"
          <|
            \x y z ->
                let
                    e =
                        Left x

                    f =
                        (+) y

                    g =
                        (*) z
                in
                    Expect.equal True
                        (mapLeft (g << f) e == (mapLeft g << mapLeft f) e)
        ]


applicative : Test
applicative =
    describe "Applicative"
        [ test "Identity law: singleton identity |> andMap v == v" <|
            \() ->
                let
                    e =
                        Right ()
                in
                    singleton identity
                        |> andMap e
                        |> (==) e
                        |> Expect.equal True
        , test "Companion to Identity law" <|
            \() ->
                let
                    e =
                        Left ()
                in
                    Left identity
                        |> andMapLeft e
                        |> (==) e
                        |> Expect.equal True
        ]
