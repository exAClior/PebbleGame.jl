# Theory

In this section, we will discuss the theoretical aspects of finding out the
optimal strategy in executing a given program. The notion of optimal concerns
two resources: time and space. By time we mean the number of basic operations it
takes to compute a program. In this step, we are making a simplification of
treating all operations having the same time. By space, we mean the number of
registers needed for carrying out the basic operations.

To put it more concretely, consider the program that computes $Y = A * B + C$.
We may visualize the process of computation with the following [computation
graph](https://www.cs.cornell.edu/courses/cs5740/2017sp/lectures/04-nn-compgraph.pdf).

![](computation_graph.svg)

The circles with alphabets in them denotes input data. The circles with
operators in them denotes operations whose parameters are data in the head
vertex of edges pointing to operator vertex. 

The process of computation consists of loading data into register, performing
operations on data in the register and storing the result to another register.
When the data stored in a variable is loaded in the register, we mark the
corresponding vertex in the computation graph as colored. Maximum number of
vertices colored during the process of computaiton is the space cost of
performing such computation. Consider the following example in [^1]

![](sethi_eg.svg)

There are two ways of performing the computation.

1. 
```math
   r1 \leftarrow c \\
   r2 \leftarrow x \\
   r1 \leftarrow r1 * r2 \\
   r3 \leftarrow b \\
   r1 \leftarrow r1 + r3 \\
   r1 \leftarrow r1 * r2 \\
   r2 \leftarrow a \\
   r3 \leftarrow r1 + r2 \\
```

Clearly, we used three registers

2. 

```math
   r1 \leftarrow c \\
   r2 \leftarrow x \\
   r1 \leftarrow r1 * r2 \\
   r3 \leftarrow b \\ 
   r1 \leftarrow r1 + r2 \\
   r2 \leftarrow x  \\
   r1 \leftarrow r1 * r2 \\
   r2 \leftarrow a \\ 
   r1 \leftarrow r1 + r2 \\
```

By reordering computation order, we are able to save one register. The question
is that whether we have a way of automatically determining the best comptuaiton
order that uses the least amount of registers. If so, how costly is the
computation.

[^1]: [Sethi1973](@cite)

## Space-time trade off Problem


1. Define the problem rigorously. Classical erasure, reversible , ....

2. Why is it a PSPACE Complete problem?
3. What is the rigorous difference between NP-Complete and PSPACE-Complete problems? Why are we not certain that PSPACE-Complete problems are not equal to NP-Complete? [Ref1](https://www.quora.com/What-makes-any-NP-complete-problem-a-PSPACE-complete-problem-in-the-complexity-theory-field#:~:text=Every%20problem%20in%20NP%20is,problems%20are%20also%20PSPACE%2Dcomplete.) , [Ref2](https://cs.stackexchange.com/questions/43723/what-is-practical-difference-between-np-and-pspace-complete).


4. Eventually, we would like to know from the complexity class of this problem whether tree-width related algorithms can help with solving our problem.

5. 


