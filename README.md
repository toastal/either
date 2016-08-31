# Either

A generic structure for a type with two possibilities: a `Left a` or
a `Right b`.

An `Either` is right-biased, so most operations will be applied to
the `Right`—although most operations are provided for `Left` as well.

This is similar to
[`Result`](http://package.elm-lang.org/packages/elm-lang/core/latest/Result)
type in
[`core`](http://package.elm-lang.org/packages/elm-lang/core/latest)
, but is more generic.  If you’re looking for a data type to do error
handling, you should use `Result` instead.
