# SwiftLand µframework v2.0

This small library contains useful higher-order functions which can be used to simplify Swift development. This is not a functional programming library, because I believe there does not exist such a thing. We can define functional programming as *programming only with computable (possibly non-terminating) Scott-continuous functions which map set of inputs (domain) to the set of permissible outputs (codomain) with the property that each input is related to exactly one output*. In simple words functional programming is about side effects, how to deal with them, how to make them explicit and how to reason about the whole program mathematically. So if we stick to this definition it will become clear that one library can not guarantee these properties without support from the language and runtime and Swift by design is not a functional language.

<p>What SwiftLand does is add functions similar to ones found in Haskell Data/Prelude libraries to reduce code boilerplate. Each function has detailed comments, which can be used as documentation.</p>

SwiftLand contains:
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



# Adding library using [Carthage](https://github.com/Carthage/Carthage):

In your [Cartfile](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) specify `github  "AlexanderKaraberov/SwiftLand"`
