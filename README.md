# Either

A generic structure for a type with two possibilities: a `Left a` or
a `Right b`.

An `Either` is right-biased, so most operations will be applied to
the `Right`.

This is similar to
[`Result`](http://package.elm-lang.org/packages/elm-lang/core/latest/Result)
type in
[`core`](http://package.elm-lang.org/packages/elm-lang/core/latest)
, but is more generic.  If your looking for a data type to do error
handling, you should use `Result` instead.
