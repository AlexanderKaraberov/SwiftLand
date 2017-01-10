# SwiftLand µframework v2.0

This small library contains useful higher-order functions which can be used to simplify Swift development. This is not a functional programming library, because FP is **not** about higher-order functions like `map`/`reduce`, or pattern matching, or first-class functions, or any other stuff which people _claim_ "functional programming". All these are useful language constructs and common sense, nothing more. Functional programming is *programming only with computable (possibly non-terminating) Scott-continuous functions which map set of inputs (domain) to the set of permissible outputs (codomain) with the property that each input is related to exactly one output*. In simple words, informally, functional programming is about side effects, how to deal with them, how to make them explicit and how to reason about the whole program mathematically.
<p> `SwiftLand` tries to reimplement functions similar to ones found in Haskell Data/Prelude libraries. Each function has detailed comments, which you can use as docs. Swift standard library already contains a lot of higher order functions and the intent of this libary is just to add more of them.
<p> Swift continuously evolves, so periodically I remove some functions from the library, because Swift standard library already contains them (such as [UnfoldSequence](https://developer.apple.com/reference/swift/unfoldsequence), dropLast, dropFirst, [prefix(while:)/drop(while:)](http://rosslebeau.com/2016/swift-3-1-prefixwhile-dropwhile) and so on)
<p>  *Currently* `SwiftLand` contains:
* Catamorphism: `foldRight` (fold from the right). Swift currently has only [reduce](https://developer.apple.com/library/ios/documentation/Swift/Reference/Swift_SequenceType_Protocol/index.html#//apple_ref/swift/intfm/SequenceType/s:FeRq_Ss12SequenceType_SsS_6reduceu__Rq_S__Fq_FzTqd__7combineFzTqd__qqq_S_9GeneratorSs13GeneratorType7Element_qd___qd__) function, which is equivalent to the `foldLeft` in classic FP literature.
* Special cases of `foldLeft` and `foldRight`: `foldLeft1` and `foldRight1` which use array's first element as initial element and don't work for empty lists.
* Hylomorphism (`hylo`) and paramorphism (`para`) which are decribed in classical paper about recursion schemes: [Functional Programming with Bananas  Lenses  Envelopes and Barbed Wire](http://eprints.eemcs.utwente.nl/7281/01/db-utwente-40501F46.pdf)
* Special folds: `sum`, `product`.
* `mapWithIndex`, `until`
* `curry`, and its inverse `uncurry` for different number of arguments.
*  General purpose list processing functions: `filterLength`, `intercalate`, `null`, `concat`, `intersperse`, `span`, `concatMap`, `groupBy`, `splitAt`, `find`, `remove`, `uniq`, `scanl`, `iterateWhile`, `decompose`.
* Cons lists with list pattern matching
* Zipping/unzipping lists: `zip3`, `zipWith`, `unzip`. (Swift standard library already has a usual [zip](https://developer.apple.com/library/prerelease/ios/documentation/Swift/Reference/Swift_StandardLibrary_Functions/index.html#//apple_ref/swift/func/s:FSs3zipu0_Rq_Ss12SequenceTypeq0_S__FTq_q0__GVSs12Zip2Sequenceq_q0__) function)
* [Combinators](https://wiki.haskell.org/Combinator). Besides well-known combinators from [SKI](https://en.wikipedia.org/wiki/SKI_combinator_calculus)/[BCKW](https://en.wikipedia.org/wiki/B,_C,_K,_W_system), I also will add one by one combinators from the great book [To Mock a Mockingbird](https://en.wikipedia.org/wiki/To_Mock_a_Mockingbird). Currently implemented in Combinators.swift: C-combinator (`flip`), K-combinator (`const`), Y-combinator: (`fix`), I-combinator (`id`), Psi-combinator (`on`), S-combinator (`substitute`), B-combinator (compose), A-combinator (apply), W-combinator (duplicate).



#Adding library using [Carthage](https://github.com/Carthage/Carthage):

In your [Cartfile](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) specify `github  "AlexanderKaraberov/SwiftLand"`
<p>And then write: `import SwiftLand`
