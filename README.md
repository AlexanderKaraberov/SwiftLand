# SwiftLand µframework v1.0.3

This small library contains useful higher-order functions (functionals) to simplify general Swift development. This can be considered as "functional" sugar. Library will contain only general-purpose functions without abstract functional pattens and category theory concepts. The main idea of SwiftLand is to support idea of [functional in the small, OOP in the large](http://www.johndcook.com/blog/2009/03/23/functional-in-the-small-oo-in-the-large/), and not to pretend that Swift is a purely functional language, because it is [not](https://en.wikipedia.org/wiki/Referential_transparency), so there are no `Monads`, `Monad Transformers`, `Arrows`, `Comonads` and so on in it, but only small standalone functions. This is not a functional programming library, because FP is **not** about higher-order functions like `map`/`reduce` or lambda functions or pattern matching or first-class functions or any other stuff which people _claim_ "functional programming". This library is more like a DSL for data processing which encourages you to apply the main idea of functional programming paradigm in everyday tasks, which is exactly *programming only with computable (possibly non-terminating) mathematical Scott-continuous functions which map set of inputs (domain) to the set of permissible outputs (codomain) with the property that each input is related to exactly one output and nothing else*. In simple words: FP is about side-effects and how to avoid them.
This library will selectively include some code from beautiful https://github.com/typelift frameworks, but only practical functions, which I consider useful for everyday iOS development tasks. 
<p> `SwiftLand` also tries to reimplement functions similar to ones found in Haskell Data/Prelude libraries. In addition there will be some general helpers. Each function has detailed comments, which you can use as docs. Swift standard library already contains a lot of higher order functions and the intent of this libary is just to add more of them.
<p>  *Currently* `SwiftLand` contains:
* Catamorphism: `foldRight` (fold from the right). Swift currently has only [reduce](https://developer.apple.com/library/ios/documentation/Swift/Reference/Swift_SequenceType_Protocol/index.html#//apple_ref/swift/intfm/SequenceType/s:FeRq_Ss12SequenceType_SsS_6reduceu__Rq_S__Fq_FzTqd__7combineFzTqd__qqq_S_9GeneratorSs13GeneratorType7Element_qd___qd__) function, which is equivalent to the `foldLeft` in classic FP literature.
* Special cases of `foldLeft` and `foldRight`: `foldLeft1` and `foldRight1` which use array's first element as initial element and don't work for empty lists.
* Anamorphism: `unfoldr`.
* Hylomorphism (`hylo`) and paramorphism (`para`) which are decribed in classical paper about recursion schemes: [Functional Programming with Bananas  Lenses  Envelopes and Barbed Wire](http://eprints.eemcs.utwente.nl/7281/01/db-utwente-40501F46.pdf)
* Special folds: `any`, `all`, `or`, `and`, `sum`, `product`.
* `mapWithIndex`, `until`
* Helpers for 2-tuples (pairs): `swap`, tuple comparison, because Swift currently [doesn't](https://github.com/apple/swift-evolution/blob/master/proposals/0015-tuple-comparison-operators.md) have this.
* `curry`, and its inverse `uncurry` for different number of arguments.
* General purpose list processing functions: `filterLength`, `intercalate`, `null`, `tail`/`head`/`drop`, `takeWhile`, `dropWhile`, `concat`, `intersperse`, `span`, `concatMap`, `groupBy`, `splitAt`, `find`, `remove`, `uniq`, `scanl`.
* Cons lists with list pattern matching
* Zipping/unzipping lists: `zip3`, `zipWith`, `unzip`. (Swift standard library already has a usual [zip](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Reference/Swift_StandardLibrary_Functions/index.html#//apple_ref/swift/func/s:FSs3zipu0_Rq_Ss12SequenceTypeq0_S__FTq_q0__GVSs12Zip2Sequenceq_q0__) function)
* [Combinators](https://wiki.haskell.org/Combinator):  C-combinator (`flip`), K-combinator (`const`), Y-combinator: (`fix`), I-combinator (`id`), Psi-combinator (`on`), S-combinator (`substitute`) 
* Utils for dates, images, colors.
* String extensions and higher order functions

#Adding library using [Carthage](https://github.com/Carthage/Carthage):

In your [Cartfile](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) specify `github  "AlexanderKaraberov/SwiftLand"`
<p>And then write: `import SwiftLand`
