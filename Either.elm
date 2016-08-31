module Either exposing (..)

{-|
A generic structure for a type with two possibilities: a `Left a` or
a `Right b`.

An `Either` is right-biased, so most operations will be applied to
the `Right`.

This is similar to `Result` type in `core`, but is more generic.
If your looking for a data type to do error handling, you should
use `Result` instead.


# Definition
@docs Either

# Mapping
@docs map, map2, map3, mapLeft, mapRight, mapBoth

# Singleton & Applying
@docs singleton, andMap

# Chaining
@docs andThen

# List Helpers
@docs lefts, rights, partition

# Maybe Helpers
@docs leftToMaybe, rightToMaybe, toMaybe, fromMaybe

# Result Helpers
@docs toResult, fromResult

# Rest of the Helpers
@docs isLeft, isRight, fromLeft, fromRight, withDefault, elim, either, swap
-}

import Result exposing (Result(Err, Ok))


-- TYPE


type Either a b
    = Left a
    | Right b



-- FUNCTOR


{-| Apply a function to an `Either`. If the argument is `Right`, it
will be converted.  If the argmetn is an `Left`, the same left value
will propogate through.
-}
map : (a -> b) -> Either x a -> Either x b
map f e =
    case e of
        Right b ->
            Right <| f b

        Left a ->
            Left a


{-| Apply a function to two eithers, if both arguments are `Right`.
If not, the first argument which is a `Left` will propagate through.
Also known as `liftA2`.
-}
map2 : (a -> b -> c) -> Either x a -> Either x b -> Either x c
map2 f e e' =
    case ( e, e' ) of
        ( Right a, Right b ) ->
            Right <| f a b

        ( Left x, _ ) ->
            Left x

        ( _, Left x ) ->
            Left x


{-| Like `map2`, but with 3 eithers. Also known as `liftA3`
-}
map3 : (a -> b -> c -> d) -> Either x a -> Either x b -> Either x c -> Either x d
map3 f e e' e'' =
    case ( e, e', e'' ) of
        ( Right a, Right b, Right c ) ->
            Right <| f a b c

        ( Left x, _, _ ) ->
            Left x

        ( _, Left x, _ ) ->
            Left x

        ( _, _, Left x ) ->
            Left x


{-| Apply a function to the `Left` of an `Either`.
-}
mapLeft : (a -> b) -> Either a x -> Either b x
mapLeft f e =
    case e of
        Left a ->
            Left <| f a

        Right b ->
            Right b


{-| Alias for `map`.
-}
mapRight : (a -> b) -> Either x a -> Either x b
mapRight =
    map


{-| Apply the first argument function to a `Left` and the second
argument function to a `Right` of an `Either`.
-}
mapBoth : (a -> b) -> (c -> d) -> Either a c -> Either b d
mapBoth f g e =
    case e of
        Left a ->
            Left <| f a

        Right b ->
            Right <| g b



-- APPLICATIVE


{-| Create a `singleton` from a value to an `Either` with a `Right`
of the same type.  Also known as `pure`.
-}
singleton : b -> Either x b
singleton =
    Right


{-| Apply the function that is inside `Either` to a value that is inside
`Either`. Return the result inside `Either`. If one of the `Either`
arguments is `Left x`, return `Left x`. Also known as `apply`.
-}
andMap : Either x (a -> b) -> Either x a -> Either x b
andMap e e' =
    case ( e, e' ) of
        ( Left x, _ ) ->
            Left x

        ( Right f, r ) ->
            map f r



-- MONAD


{-| Chain together in many computations that will stop computing if
a chain is on a `Left`. Also known as `bind`.
-}
andThen : Either x a -> (a -> Either x b) -> Either x b
andThen e f =
    case e of
        Right b ->
            f b

        Left a ->
            Left a



-- COMBINATORS
-- LIST HELPERS


{-| Converts a `List` of `Either a x` to a List of `a`.
-}
lefts : List (Either a x) -> List a
lefts =
    List.foldr
        (\e acc ->
            case e of
                Left a ->
                    a :: acc

                _ ->
                    acc
        )
        []


{-| Converts a `List` of `Either x b` to a List of `b`.
-}
rights : List (Either x b) -> List b
rights =
    List.foldr
        (\e acc ->
            case e of
                Right b ->
                    b :: acc

                _ ->
                    acc
        )
        []


{-| Converts a `List` of `Either a b`, into a tuple2 where
the first value is a `List a` and the second is `List b`.
-}
partition : List (Either a b) -> ( List a, List b )
partition =
    let
        fun e ( ls, rs ) =
            case e of
                Left a ->
                    ( a :: ls, rs )

                Right b ->
                    ( ls, b :: rs )
    in
        List.foldr fun ( [], [] )



-- MAYBE HELPERS


{-| `Maybe` get the `Left` side of an `Either`.
-}
leftToMaybe : Either a x -> Maybe a
leftToMaybe e =
    case e of
        Left x ->
            Just x

        _ ->
            Nothing


{-| `Maybe` get the `Right` side of an `Either`.
-}
rightToMaybe : Either x b -> Maybe b
rightToMaybe e =
    case e of
        Right x ->
            Just x

        _ ->
            Nothing


{-| Alias for `rightToMaybe`.
-}
toMaybe : Either x a -> Maybe a
toMaybe =
    rightToMaybe


{-| Convert from a `Maybe` to `Either` with a default value
for `Nothing`.
-}
fromMaybe : a -> Maybe b -> Either a b
fromMaybe d m =
    case m of
        Just v ->
            Right v

        Nothing ->
            Left d



-- RESULT HELPERS


{-| Convert from `Either` to `Result`.
-}
toResult : Either a b -> Result a b
toResult e =
    case e of
        Left a ->
            Err a

        Right b ->
            Ok b


{-| Convert from `Result` to `Either`.
-}
fromResult : Result a b -> Either a b
fromResult r =
    case r of
        Err a ->
            Left a

        Ok b ->
            Right b



-- REST OF THE HELPERS


{-| Returns `True` if argument is `Left _`
-}
isLeft : Either a b -> Bool
isLeft e =
    case e of
        Left _ ->
            True

        _ ->
            False


{-| Returns `True` if argument is `Right _`
-}
isRight : Either a b -> Bool
isRight e =
    case e of
        Right _ ->
            True

        _ ->
            False


{-| Extract left value or a default.
-}
fromLeft : a -> Either a b -> a
fromLeft d e =
    case e of
        Left a ->
            a

        _ ->
            d


{-| Extract right value or a default.
-}
fromRight : b -> Either a b -> b
fromRight d e =
    case e of
        Right b ->
            b

        _ ->
            d


{-| Alias for `fromRight`
-}
withDefault : b -> Either a b -> b
withDefault =
    fromRight


{-| Given a function for both `Left` and `Right` to to type a generic
type `c`, collapse down the `Either` to a value of that type.
-}
elim : (a -> c) -> (b -> c) -> Either a b -> c
elim f g e =
    case e of
        Left a ->
            f a

        Right b ->
            g b


{-| Alias for `elim`.
-}
either : (a -> c) -> (b -> c) -> Either a b -> c
either =
    elim


{-| Swap the `Left` and `Right` sides of an `Either`.
-}
swap : Either a b -> Either b a
swap e =
    case e of
        Left a ->
            Right a

        Right b ->
            Left b
