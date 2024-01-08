# Either

A generic structure for a type with two possibilities: a `Left a` or
a `Right b`.

An `Either` is right-biased, so most operations will be applied to
the `Right`—although many operations are provided for `Left` as well.

This is similar to
[`Result`](http://package.elm-lang.org/packages/elm-lang/core/latest/Result)
type in
[`core`](http://package.elm-lang.org/packages/elm/core/latest)
, but is more generic.  If you’re looking for a data type to do error
handling, you should use `Result` instead.

---

## Project & Community Notes

This project is regrettably available on [GitHub](https://github.com/toastal/either). The Elm community has tied itself to the closed-source, Microsoft-owned code forge of GitHub for package registry and identity. This does not protect the privacy or freedom to its community members.

---

## License

This project is licensed under Apache License 2.0 - [LICENSE](./LICENSE) file for details.

## Funding

If you want to make a small contribution to the maintanence of this & other projects

- [Liberapay](https://liberapay.com/toastal/)
- [Bitcoin: `39nLVxrXPnD772dEqWFwfZZbfTv5BvV89y`](link:bitcoin://39nLVxrXPnD772dEqWFwfZZbfTv5BvV89y?message=Funding%20toastal%E2%80%99s%20Elm%20either%20development
) (verified on [Keybase](https://keybase.io/toastal/sigchain#690220ca450a3e73ff800c3e059de111d9c1cd2fcdaf3d17578ad312093fff2c0f))
- [Zcash: `t1a9pD1D2SDTTd7dbc15KnKsyYXtGcjHuZZ`](link:zcash://t1a9pD1D2SDTTd7dbc15KnKsyYXtGcjHuZZ?message=Funding%20toastal%E2%80%99s%20Elm%20either%20development) (verified on [Keybase](https://keybase.io/toastal/sigchain#65c0114a3c8ffb46e39e4d8b5ee0c06c9eb97a02c4f6c42a2b157ca83b8c47c70f))
