# SwiftLand µframework

This small library contains useful higher order functions to simplify general Swift development in "functional" style. It will contain only general-purpose functions without abstract pattens and category theory concepts. The main idea of SwiftLand is to support idea of [functional in the small, OOP in the large](http://www.johndcook.com/blog/2009/03/23/functional-in-the-small-oo-in-the-large/), and not to pretend that Swift is a purely functional language, because it is [not](https://en.wikipedia.org/wiki/Referential_transparency), so there are no `Monads`, `Monad Transformers`, `Arrows`, `Comonads` and so on in it, but only small standalone functions. Also you should read [this paper](https://queue.acm.org/detail.cfm?id=2611829).
This library will selectively include some code from beautiful https://github.com/typelift frameworks. Also `SwiftLand` tries to reimplement functions similar to ones found in Haskell Data/Prelude libraries in idiomatic Swift way. In addition there will be some general helpers for everyday tasks. Each function has detailed comments, which you can use as docs. Swift standard library already contains a lot of higher order functions for high level functional data processing. The intent of this libary is just to add more.
<p> Currently it has:
* Catamorphisms (folds). Because Swift currently has only fold left (`reduce`).
* Anamorphism (`unfoldr`)
* `mapWithIndex`
* General purpose list functions: `intercalate`, `null`, `tail`/`head`/`drop`, cons lists, `concat`, `intersperse`, `span`, `concatMap`, `groupBy`, `any`, `all`, `splitAt`, `find`.
* Zipping/unzipping lists: `zip3`, `zipWith`, `unzip`. (Swift standard library already has a usual [zip](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Reference/Swift_StandardLibrary_Functions/index.html#//apple_ref/swift/func/s:FSs3zipu0_Rq_Ss12SequenceTypeq0_S__FTq_q0__GVSs12Zip2Sequenceq_q0__) function)
* Combinators (`flip`,`const`, `fix` or Y combinator)
* Utils for dates, images, colors.
* Scans: `A "scan" is like a cross between a map and a fold. Folding a list accumulates a single return value, whereas mapping puts each item through a function returning a separate result for each item. A scan does both: it accumulates a value like a fold, but instead of returning only a final value it returns a list of all the intermediate values.`
* String extensions and higher order functions
* Collection extensions (`removeObject`, `uniq`)
