Either
======

A generic structure for a type with two possibilities: a ``Left a`` or a ``Right b``.

An `Either` is right-biased, so most operations will be applied to the ``Right``\—although many operations are provided for ``Left`` as well.

This is similar to Result_ type in core_, but is more generic.
If you’re looking for a data type to do error handling, you should use ``Result`` instead.

.. |Result| replace:: ``Result``
.. _Result: http://package.elm-lang.org/packages/elm-lang/core/latest/Result
.. |core| replace:: ``core``
.. _core: http://package.elm-lang.org/packages/elm/core/latest


Project & Community Notes
=========================

This project is regrettably available on GitHub_.
The Elm community has tied itself to the closed-source, Microsoft-owned code forge of GitHub for package registry and identity.
This does not protect the privacy or freedom of its community members.

.. _GitHub: https://github.com/toastal/either


License
=======

This project is licensed under Apache License 2.0 (Apache-2.0_) - ``LICENSE.txt`` file in this project for details.

.. _Apache-2.0: https://www.apache.org/licenses/LICENSE-2.0


Funding
=======

If you want to make a small contribution to th maintenance of this & other projects.

Crowdfunding
	• Liberapay: `@toastal <https://liberapay.com/toastal>`_

Cryptocurrency
	• Bitcoin: 39nLVxrXPnD772dEqWFwfZZbfTv5BvV89y_ (`BTC verified on Keybase <https://keybase.io/toastal/sigchain#690220ca450a3e73ff800c3e059de111d9c1cd2fcdaf3d17578ad312093fff2c0f>`_)
	• Zcash: t1a9pD1D2SDTTd7dbc15KnKsyYXtGcjHuZZ_ (`ZEC verified on Keybase <https://keybase.io/toastal/sigchain#65c0114a3c8ffb46e39e4d8b5ee0c06c9eb97a02c4f6c42a2b157ca83b8c47c70f>`_)

.. _39nLVxrXPnD772dEqWFwfZZbfTv5BvV89y: bitcoin://39nLVxrXPnD772dEqWFwfZZbfTv5BvV89y?message=Funding%20toastal%E2%80%99s%20nvim-tree-sitter-unicode-conceal%20development
.. _t1a9pD1D2SDTTd7dbc15KnKsyYXtGcjHuZZ: zcash://t1a9pD1D2SDTTd7dbc15KnKsyYXtGcjHuZZ?message=Funding%20toastal%E2%80%99s%20nvim-tree-sitter-unicode-conceal%20development
