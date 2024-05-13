

# Purpose

Memory and time are the only two scarce resource in terms of classical
computation. It is interesting to consider how much memory is required and how
long does it take with those given memory to perform a computation. To study
this prolem, a mathematical model called pebbled game was proposed and developed
over the years. We make a brief survey in this field.

# Black Pebble Game

Originally, black pebble game was implicitly introduced in
<cite:&ComparativeSchematology>. Later <cite:&sethiCompleteRegisterAllocation1973>
used a similar to study the time-space complexity trade-off of evaluating a
piece of straight-line program. The name pebble game was coined in that paper.
To differentiate it from its variants, we may also call it the **black pebble
game**. A **straight-line program** is one without branch or loops. A **pebble game**
converts such a straight-line program into a directed acyclic graph.
Gates/computations in the program are represented by vertices. Vertex A has an
outgoing edge into vertex B if the output of the gate represented by vertex A is
the input of the gate represented by gate B. Final results of a program is
represented by vertices with no outgoing edges. Pebbling a vertex represents
doing a computation. The goal of the game is to pebble all output vertices at
least once each while following some constraints. In the black pebble game,
there are two constraints for pebbling and unpebbling.

To pebble a vertex, all vertices with outgoing edge towards the vertex needs to
be pebbled already. To unpebble a vertex, the vertex must be already pebbled.
The vertices representing the inputs can be pebbled with no constraint.

For example, <cite:&marchalPartPebblegameModels> gives the pebble game setup of
the computation $7 + (5 − z) × (1 + x) − (1 + x − t)/(2 + z) + v$ as follows
[pebble game example](resources/Screenshot 2024-05-09 at 20.15.04.png).

In this model, the question of how much memory is needed to perform a computaion
turns into how many pebbles is needed to finish a pebble game. Much effort in
the academic world was devote to answering related questions.


## Optimal Strategy

It&rsquo;s trivial to see that the space cost is upper-bounded by the number of
vertices in the DAG. It&rsquo;s interesting to find a non-trivial upper-bound. This
corrsponds to the minimal space strategy for a pebble game. Meanwhile, it is
also interesting to find an algorithm that efficiently finds a game strategy
that reaches this bound.


### Miminal Space Stragey

The second question was answered first in a series of paper
<cite:&sethiCompleteRegisterAllocation1973;&louiMinimumRegisterAllocation1979;&gilbertPebblingProblemComplete1980>.
It was shown that the question of whether $k$ pebbles are enough to finish a
black pebble game is $NP-Complete$ <cite:&sethiCompleteRegisterAllocation1973>. An
explicit reduction from $3-SAT$ problem to pebble game was made. The big picture
was to represent all literals, $x_i$ and $\bar{x_{i}}$, all clauses in the
$3-SAT$ as vertices. Extra vertices are added to represent the choice of a value
for a given variable $x_i$. Edges are chosen such that vertices representing the
clauses are connected to corresponding literals to represent choosing the value
for a literal. Conversely, the state of the art solution towards a $k$ pebble
game will be provided by first converting the pebble game into a SAT problem and
then using a SOTA solve for SAT problem documented in [Wikipedia](https://en.wikipedia.org/wiki/SAT_solver). In order to get
the minimal pebbles needed for the pebble game on a DAG, it was shown that it is
in $PSPACE-complete$ complexity class
<cite:&louiMinimumRegisterAllocation1979;&gilbertPebblingProblemComplete1979>.
Finally, the question we pose at the beginning of the section was answer in
<cite:&hopcroftTimeSpace1977;&pippengerTimeSpaceTradeOff1978>. A tighter
upper-bound for the pebbles is $V/\log(V)$ where $V$ is the number of vertices
in the DAG.

In conclusion, we now understand that asking about the minimal space for
carrying out a computation is hard, $PSAPCE-complete$ hard. Nevertheless, there
are three areas un-explored. Firstly, the complexity conclusion was towards a
DAG with no structure. We could expect more efficient solution when the circuit,
hence the DAG, has some structure. For example, when the computation being
carried out is $FFT$, the DAG could be dividied into identical completely
balanced binary trees <cite:&ModelsComputationExploring>. Secondly, we may trade
space for time during computation <cite:&gilbertPebblingProblemComplete1979>. For
example, by giving one extra pebble you may save much running time. Lastly,
operations allowed in this model is limited and it corresponds to irreversible
and straight-line programs. Are there any variants of pebble games that could be
used to analyze other computational models?


### DAG with structure

For results regarding DAG with structure, a collection of results regarding DAG
for FFT <cite:&savageSpacetimeTradeoffsFFT1978>, DFT, and functions in
general<cite:&tompaTimespaceTradeoffsComputing1980> are recorded in Chapter 10 of
<cite:&ModelsComputationExploring>. One example is: if the DAG of the program is a
completely balanced tree of level $k$, we may use recursive proof to derive the
lower bound on memory used being $k+1$ pebbles.


### Space-Time Trade Off (needs revisit)

Noting that space is not the only important resource, it is also interesting to
study the time and space trade off with pebble game framework. The first
interesting work is done in <cite:&pippengerTimeSpaceTradeOff1978>. There are two
important assumptions: he didn&rsquo;t consider the commuting property of expressions
and he assumed all operation takes the same amount of time. He obtained the
result that some graph will need to pay at a lower bound $\Omega(Vloglog(V))$ amount
of time in order to achieve the $O(V/log(V))$ best general space complexity
previously proposed in <cite:&hopcroftTimeSpace1977>. Previous work didn&rsquo;t shown
such sacrifice in time. The problems is that this lower bound is too far away
from the $\mathcal{O}(V/log(V))$ upper bound.

Two natrual question follows are: What are the work that closes the two bounds?
Are there any graph to which the $\mathcal{O}V/log(V)$ memory is necessary? The first
problem is answered in
<cite:&lengauerAsymptoticallyTightBounds1982;&lengauerUpperLowerBounds1979>. No
one seems to be following it. The second one is answered in
<cite:&paulSpaceBoundsGame1976;&CorrectionSpaceBounds1977>. In
<cite:&paulSpaceBoundsGame1976>, an algorithm for solving the pebbling problem is
also given.

A more theory of computation related review was given in section 2 of chapter 10
in <cite:&kapronLogicAutomataComputational2023>.


### Approximation of answer and Applications

Now that we have a good idea of how hard the problem is and what is the best we
could do. We are interested in what kind of approximation algorithms we could
employ and what kind of novel applications we could do. In
<cite:&yannakakisPolynomialAlgorithmMincut1985>, algorithm was proposed to find
the $MINCUT$ problem of a tree in $\mathcal{O}(n\log n)$ time. Due to it&rsquo;s close relation,
this algorithm will also compute the number of pebbles needed on a black-white
pebble game on a tree. In <cite:&chanHardnessApproximationPSPACE2015>, it was
shown that reversible pebbling is also PSPACE-hard. Furthermore, the
approximation the min space result upto an addative constant is also PSAPCE-hard
<cite:&chanHardnessApproximationPSPACE2015;&demaineInapproximabilityStandardPebble2017>.
In <cite:&kumarEfficientRematerializationDeep2019>, an algorithm was given to find
peak memory and computation length of a computation to certain bound. This is
almost identical to the pebble game setting. In
<cite:&fellnerGreedyPebblingProof2019>, we see a modern presentation of converting
the pebbling problem into a SAT problem for answer to desired complexity. The
previous paper should be viewed in tandem with
<cite:&pappHardnessRedBluePebble2020> to see how greedy algorithm fails to obtain
optimal solution. This paper <cite:&jinNewToolsPeak2023> introduces dominance for
finding the sub-optimal solution. Need to give a close look.


### Variants

-   What are their each complexity.
-   Progressive Pebble Game

1.  Dymond and Tompa Pebble Game

    For modeling the time and space complexity of parallel computing
    <cite:&liuRedBlueStandardPebble>.

2.  Red Black Pebble Game

    Red-blue pebble game is used to study I/O complexity. In the thesis
    <cite:&liuRedBlueStandardPebble>, addative complexity was also shown to be
    PSPACE-hard.

3.  Reversible Pebble Game

    For modeling reversible computing.

4.  Black White Pebble Game

    For modeling non-deterministic computing.


# Reversible Pebble Game

What is the state of the art?
What is the con


# Spooky Pebble Game

Why this?
What is the state of the art?


# What remains

-   Non-line program? what are the model for
-   MCTS for solving pebble game?
-   What family of graphs does useful quantum oracles lie?
-   Even proving minimal space is hard, so space-time trade off has been left
    blank? Why?


# Appendix


## PSPACE

To investigate complexity of a problem $\mathcal{Q}$ under the physical constraint of
limited physical space, we propose a new complexity class $SPACE(f(n))$.
Problems in $SPACE(f(n))$ can be solved by a bounded-memory $Random Access
Machine$ model with read-only access to the input of a problem and $O(f(n))$
amount of memory <cite:&mooreNatureComputation2011>. A bounded-memory $Random
Access Machine$ model is one where there exists two components, A CPU and a
Random Access Memory. A CPU can request data from arbitrary address $adr$ and
execute command upon receiving data. A $Random Access Memory$ can accept an
address request and output data in $O(1)$ time.

$PSPACE$ is the complexity class of a the collection $SPACE(n^c)$ for $0<= c <=
\inf$.


## Other usecases

Besides studying of space-time complexity in computation. Pebble game model has
also seen its usage in many other fields. I merely list them here without
understanding much.

-   [Nullstellensatz Size-Degree Trade-offs from Reversible Pebbling](https://arxiv.org/pdf/2001.02481) is about proof
    complexity
-   [[<https://arxiv.org/pdf/1802.07433>][Static-Memory-Hard Functions and Nonlinear Space-Time

Tradeoffs via Pebbling]] is about cryptography, hash-function.

-   [Proof system thesis](http://kth.diva-portal.org/smash/get/diva2:1094244/FULLTEXT01.pdf): resources required for a propositional proof system and
    [paper](https://arxiv.org/pdf/1307.3913) , [paper2](https://arxiv.org/pdf/1307.3913) too.
-   [Efficient evaluation of adjoint](https://www.sciencedirect.com/science/article/pii/S1570866708000737)


## People

-   [Jakob Nordstorm](https://jakobnordstrom.se/)
-   [Nicholas Pippenger](https://www.hmc.edu/mathematics/people/faculty/nicholas-pippenger/)
-   [Torsten Hoefler](http://htor.ethz.ch/) parallel computing etc


## Helpful paper

-   [understand sethi](https://dl.acm.org/doi/pdf/10.1145/2779052)


# Bibliography


## References


[bibliography:./pebblegame.bib](bibliography:./pebblegame.bib)

