# SwiftLand µframework

This small library contains useful higher order functions to simplify general Swift development in "functional" style. It will contain only general-purpose functions without abstract pattens and category theory concepts. The main idea of SwiftLand is to support idea of [functional in the small, OOP in the large](http://www.johndcook.com/blog/2009/03/23/functional-in-the-small-oo-in-the-large/), and not to pretend that Swift is a purely functional language, because it is [not](https://en.wikipedia.org/wiki/Referential_transparency), so there are no `Monads`, `Monad Transformers`, `Arrows`, `Comonads` and so on in it, but only small standalone functions. Also you should read [this paper](https://queue.acm.org/detail.cfm?id=2611829).
This library will selectively include some code from beautiful https://github.com/typelift frameworks, but only practical functions. Also `SwiftLand` tries to reimplement functions similar to ones found in Haskell Data/Prelude libraries in idiomatic Swift way. In addition there will be some general helpers for everyday tasks. Each function has detailed comments, which you can use as docs. Swift standard library already contains a lot of higher order functions for high level functional data processing. The intent of this libary is just to add more.
<p> Currently it has (0.0.4):
* `Foldr` or right fold (catamorphism), because Swift currently has only fold left (`reduce`).
* Special folds: `any`, `all`, `or`, `and`.
* `mapWithIndex`
* General purpose list functions: `intercalate`, `null`, `tail`/`head`/`drop`, `takeWhile`, `dropWhile`, cons lists, `concat`, `intersperse`, `span`, `concatMap`, `groupBy`, `splitAt`, `find`, `remove`, `uniq`, `scanl`.
* Zipping/unzipping lists: `zip3`, `zipWith`, `unzip`. (Swift standard library already has a usual [zip](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Reference/Swift_StandardLibrary_Functions/index.html#//apple_ref/swift/func/s:FSs3zipu0_Rq_Ss12SequenceTypeq0_S__FTq_q0__GVSs12Zip2Sequenceq_q0__) function)
* Combinators (`flip`,`const`, `fix` or [Y combinator](https://en.wikipedia.org/wiki/Fixed-point_combinator))
* Utils for dates, images, colors.
* String extensions and higher order functions

#Adding library using Carthage:

In your [Cartfile](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) specify `github  "AlexanderKaraberov/SwiftLand"`
