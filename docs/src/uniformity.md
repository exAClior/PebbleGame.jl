# Disipationless computation

By [Landauer's principle](https://en.wikipedia.org/wiki/Landauer%27s_principle)
erasure of information causes energy. In order to make computation more energy
efficient, we need to have it be reversible. In Bennett's paper [^1], he
proposed a method to compile reversible program from irreversible one.

As a start, there is a naive way of performing such compilation. Provided that
all atomic steps in the irreversible computation is a one-to-one function, you
may cache all intermediate computation results along the way of doing
computation. At the end of computation, you may copy the results of entire
computation onto a clean tape. Then perform the reversible computation backward.
The last step will recover you the input. Together with the output on the copied
tape, you have mapped $INPUT::00000..0000$ to $INPUT::OUTPUT$. This constitutes
a reversible mapping.

The problem with this mapping is that it is not the most efficient. For a
computation of $v$ steps, you will need to cache $v$ copies of the TM's state
machine (introduct TM somewhere before). 

## Formally Constructing a reversible TM

A single tap Turing Machine consists of four parts
1. Control Unit
2. Head that can read and write
3. An infinite tape where you the Head can read and write on.
4. A set of quintuple values which determines how the head moves.

The set of rules are defined as such $A T \rightarrow T' \sigma A'$ where $A$
and $A'$ are the state of the control unit before and after the transition.
$\sigma \in \{-1,0,1\}$ is the movement of the head. $T$ is the character on the
tape at position $i$, where the head is pointing to before the transition. $T'$
is the character written to the tape at the position $i$. 

A Turing Machine is reversible when the range of the quintuple, $T' \sigma A'$
does not overlap. However, this does not make it easily revertable without extra
information. Consider the TM at time $t+1$, it will first need to figure out
where it's head is at time $t$, then check the character at that place. Only
then, it will have all the information of $T' \sigma A'$ to go to $A T$.
However, it cannot know where it's head was supposed to be at time $t$. It needs
this extra information stored somewhere to be reversible.


## Comparison

### Standard Pebble Game

Given a straight-line program, you may first convert it into SSA format. Then
construct a computation graph output it. The minimum number of register
computation problem is PSPACE-complete.

### Bennett's Algorithm
Bennett's algorithm requires a time order which this program executes. It is
asking the problem of when to perform checkpointing. This problem is VERY
different from before. 


How can we analyze the survival time of the variables?

# Uniformity
The limitation of the previous work with Bennett is that he considers each step
in the computation taking the same memory. However, in reality, not all
varaibles needs to exist at all times. Hence the non-uniformity of the program.






[^1]: [Bennett1973](@cite)
[^2]: [Bennett1989](@cite)
