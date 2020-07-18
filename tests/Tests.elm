module Tests exposing (all)

import Either exposing (..)
import Expect
import Fuzz exposing (int)
import Test exposing (Test, describe, fuzz2, fuzz3, test)


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
                map identity e
                    |> Expect.equal (identity e)
        , test "Companion to Functor Law I" <|
            \() ->
                let
                    e =
                        Left ()
                in
                mapLeft identity e
                    |> Expect.equal (identity e)
        , fuzz3
            int
            int
            int
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
                map (g << f) e
                    |> Expect.equal (map g << map f <| e)
        , fuzz3
            int
            int
            int
            "Companion to Functor Law II"
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
                mapLeft (g << f) e
                    |> Expect.equal (mapLeft g << mapLeft f <| e)
        ]


applicative : Test
applicative =
    describe "Applicative"
        [ test "Applicative Identity Law: singleton identity |> andMap v == v" <|
            \() ->
                let
                    v =
                        Right ()
                in
                singleton identity
                    |> andMap v
                    |> Expect.equal v
        , test "Companion to Applicative Identity Law" <|
            \() ->
                let
                    v =
                        Left ()
                in
                Left identity
                    |> andMapLeft v
                    |> Expect.equal v
        , fuzz2
            int
            int
            "Applicative Homomorphism Law: singleton f |> andMap singleton x == singleton (f x)"
          <|
            \x y ->
                let
                    f =
                        (+) x
                in
                singleton f
                    |> andMap (singleton y)
                    |> Expect.equal (singleton <| f y)
        , fuzz2
            int
            int
            "Companion to Applicative Homomorphism Law"
          <|
            \x y ->
                let
                    f =
                        (+) x
                in
                Left f
                    |> andMapLeft (Left y)
                    |> Expect.equal (Left <| f y)
        , fuzz2
            int
            int
            "Applicative Interchange Law: u |> andMap (singleton y) == singleton ((|>) y) |> andMap u"
          <|
            \x y ->
                let
                    u =
                        singleton <| (+) x
                in
                u
                    |> andMap (singleton y)
                    |> Expect.equal ((|>) y |> singleton |> andMap u)
        , fuzz2
            int
            int
            "Companion to Applicative Interchange Law"
          <|
            \x y ->
                let
                    u =
                        Left <| (+) x
                in
                u
                    |> andMapLeft (Left y)
                    |> Expect.equal ((|>) y |> Left |> andMapLeft u)
        ]
