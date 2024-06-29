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
\begin{align*}
   r1 \leftarrow c \\
   r2 \leftarrow x \\
   r1 \leftarrow r1 * r2 \\
   r3 \leftarrow b \\
   r1 \leftarrow r1 + r3 \\
   r1 \leftarrow r1 * r2 \\
   r2 \leftarrow a \\
   r3 \leftarrow r1 + r2 \\
\end{align*}
```

Clearly, we used three registers

2. 

```math
\begin{align*}
   r1 \leftarrow c \\
   r2 \leftarrow x \\
   r1 \leftarrow r1 * r2 \\
   r3 \leftarrow b \\ 
   r1 \leftarrow r1 + r2 \\
   r2 \leftarrow x  \\
   r1 \leftarrow r1 * r2 \\
   r2 \leftarrow a \\ 
   r1 \leftarrow r1 + r2 \\
\end{align*}
```

By reordering computation order, we are able to save one register. The question
is that whether we have a way of automatically determining the best comptuaiton
order that uses the least amount of registers. If so, how costly is the
computation. What is the complexity class this problem resides in? The last
question is important because a tight classification of complexity class for a
problem will give us some idea about the structure of the problem and hence how
to tackle it [^2].

## Space-time trade off for Classical Straight Line Program

Before discussing about the complexity class, let's formally define the problem.

Given a [stright-line program](@ref glossary), we may first convert it into
[Static Single
Assignment](https://en.wikipedia.org/wiki/Static_single-assignment_form) form.
In the SSA form, each variable is only assigned once, therefore we could convert
each assignment of the form $X=A*B$ (let $*$ denote arbitrary operation for here
only) into three vertices in a directed graph. Edges are directed from the
vertex representing $A$ , $B$ to the vertex representing the computation result
of $A*B$.

![](computation_graph.svg)

This is how the lower left three vertices came into being in the graph above. A
well-defined computation will never use a variable that is used before
assignment. Therefore, this graph will be a directed acyclic graph. Let this
graph be denoted as $G$. [^4]

Each vertex in $G$ may have two status, pebbled or unpebbled. For vertices with
no in-coming edges, pebbling it means loading the value into a register.
Unpebbling means to remove it from the register. They could be done at arbitrary
time. For ther vertices, they could be pebbled only when the head of incoming
edges are all populated. And, they could be unpebbled if they have been pebbled
already. The process of computation is to pebble and unpebble vertices following
the above rules and finally pebble the vertex representing the output variable. 

Let's call the problem of determining the minimum number of registers (pebbles)
neede for a computation the *standard pebble game*. The input of the problem is
$G$, the *DAG* representing the computational graph. The size of the input is
$|V(G)|+|E(G)|$, the number of vertices plus the number of edges in $G$.

An accepted output for the problem is a number $n$ and a witness $w$. $n$
represents the minimum number of registers needed for computing the output
variable. $w$ is a computer program that can produce the optimal strategy of
pebbling.

### One-shot and Unbounded In-degree Version

The earlest study of the complexity class for standard pebble game is done on
$DAG$s with unbounded in-degree by [^1] with additional one-shot rule on
pebbling. Unbounded in-degree means a non-leaf vertex is computed with at most
unlimited number of inputs. One-shot rule means any vertex can be pebbled at
most once.


### General Version

The number of steps for pebbling is not necessarily polynomially bounded. [^5][^6]
Needs example.

### Variants and Complexity


There are other variants of the standard pebble game which corresponds to other
computational models like reversible computation. A good place to start for
references on what complexity class each of those problems are is this thesis
[^3].

For the sake of convinence, we copy the table that contains complexity class known for these variants here [^3].

|Type of Game | Unbounded  In-degree | Bounded  In-degree | Approximation (Additive) | FPT | 
|-------------|---------------------|--------------------|--------------------------|-----|
|Standard (one-shot) | NP-complete [Set75] | ? | ? | FPT [Thm 7.1] |
|Standard | PSPACE-complete | PSPACE-complete [GLT79] | $n^{1−ε}$ [Thm 5.1] | ? |
|Black-white | PSPACE-complete [HP1`] | ? | ? | ? |
|Reversible | PSPACE-complete  | PSPACE-complete [CLNV15] | PSPACE-complete (Constant Factor)[CLNV15] | ? |
|Red-Blue | PSPACE-complete [Thm 3.1] | PSPACE-complete [Thm 3.1] | ? | W[1]-hard k Transitions [Thm 4.1] |
|Red-Blue (no deletion) | NP-complete [Thm 3.1] | NP-complete [Thm 3.1] | ? | ? |


2. Why is it a PSPACE Complete problem?
3. What is the rigorous difference between NP-Complete and PSPACE-Complete problems? Why are we not certain that PSPACE-Complete problems are not equal to NP-Complete? [Ref1](https://www.quora.com/What-makes-any-NP-complete-problem-a-PSPACE-complete-problem-in-the-complexity-theory-field#:~:text=Every%20problem%20in%20NP%20is,problems%20are%20also%20PSPACE%2Dcomplete.) , [Ref2](https://cs.stackexchange.com/questions/43723/what-is-practical-difference-between-np-and-pspace-complete).


4. Eventually, we would like to know from the complexity class of this problem whether tree-width related algorithms can help with solving our problem.

5. 


[^1]: [Sethi1973](@cite)
[^2]: [10.5555/2086753](@cite)
[^3]: [Liu2017RedblueAS](@cite)
[^4]: [doi:10.1137/0201002](@cite)
[^5]: [Tarjan1978](@cite)
[^6]: [10.1145/800135.804418](@cite)
