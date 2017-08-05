Recursion patterns can be seen as high-order functions that encapsulate typical forms of recursion. Base such patterns are: catamorphisms (folds), anamorphisms (unfolds), paramorhisms (`foldr` with original structure passed as parameter) and **hylomorphisms** (unfold + fold). More complex and exotic recursion patterns have been discovered later, such as accumulations, histomorphisms (folds that may use the history of intermediate results, hence allow us to access all previous values, not just the most recent one), apomorphisms, zygomorphisms, futumorphisms, dynamorphisms, postpromorphisms, prepromorphisms, chronomorphisms and even their different, sometimes [crazy and useless](https://wiki.haskell.org/Zygohistomorphic_prepromorphisms) combinations. The whole zoo of all the patterns can be found [here: ](http://comonad.com/reader/2009/recursion-schemes/)
<p> _Hylomorphisms_ are recursive functions whose invocation tree (i.e., the graphical
representation of the various invocations involved in a particular function invocation)
is isomorphic to that of a function that processes lists. Roughly, two entities (for
example, collections of things, invocation trees, etc.) are isomorphic when there is a
resemblance between these two entities and one can be taken for the other. The term
hylomorphism (Greek ‘υõo-hylo-, “matter” + morphism < Greek öoû"è, morph¯e,
“form”) refers to the philosophical theory, originating with Socrates, that conceptually
identifies substance as matter and form. A hylomorphism can be viewed as
the composition of an anamorphism (from Greek: ævæ, upwards, + morphism)
that builds the invocation tree as an explicit data structure and a catamorphism
(from Greek: ôëþæ, downwards or according to, + morphism) that reduces the data
structure to a required value. The notion of hylomorphic recursive functions was
introduced by Erik Meijer,Maarten Fokkinga, and Ross Paterson.
The idea behind hylomorphisms is to be able to express (functional) programs as
instances of common patterns, rather than inventing the wheel every time we have
to solve a particular problem. After all, this is the idea behind design patterns. Thus,
one could say that hylomorphisms are a sort of design pattern for functional programming.
Since Scala is both an object-oriented and a functional programming
language, both hylomorphisms and design patterns should matter for the Scala programmer.
In order to give a practical account of hylomorphisms,we will borrow an
example from Jeremy Gibbons’ [25] lucid account of hylomorphisms (see also [26]
for a thorough description of various techniques and methodologies employed in
functional programming). Gibbons prefers the term origami programming (from
origami (from oru, folding, + kami, paper) the Japanese art of paper folding) over
hylomorphism.
In the examples below we will use lists to show what hylomorphisms can achieve.
The function that follows is a typical example of a catamorphism:

```scala
def foldL[A,B](f: (A, B) => B)(e: B)(l: List[A]): B =
l match {
case Nil => e
case x::xs => f(x, foldL(f)(e)(xs))
}
```

Note that although we use lists this definition works for any other isomorphic data
structure. Also, this function does exactly what the :/ (foldr) operator does. The
next function is a typical example of an anomorphism:

```scala
def unfoldLa[A,B](f: B => Option[Tuple2[A,B]])
(u: B):List[A] =
f(u) match {  
case None => Nil
case Some((x,v)) => x::(unfoldLa(f)(v))
}
```

This function can also be written as follows:

```scala
def unfoldL[A,B](p: B => Boolean)
(f: B => A)(g: B => B)
(b: B):List[A] =
if (p(b))
Nil
else
(f(b))::(unfoldL(p)(f)(g)(g(b)))
```

As noted above, if we compose the fold and the unfold functions,we get a hylomorphism.
A simple example of a hylomorphism is given by a function that computes
the factorial of some integer n:

```scala
def fact(n: Int) =
foldL( (_:Int) * (_:Int) )( 1 )
( unfoldL( (_:Int) == 0 )( id )( pred )( n ))
```

In a real source file the second and the third linesmust appear on the same physical
line or else the language processor will “find” errors. Also, function id returns
its argument and function pred returns its argument, if it is equal to zero, or its
argument reduced by one if it is greater than zero.
