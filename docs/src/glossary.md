# [Glossary](@id glossary)

**Straight-line programs:** Programs containing only read, output, computation
    statements. A counter example is something that has loop and branches. For
    formal definition see pp.38 of [^1].

**Language:** A set of strings from a given alphabet. An alphabet is a set of
characters. For example, $\{0,1\}$ is the binary alphabet. [^2]

- **Recoganizable:** A language $L$ is said to be recognizable by a program $P$
  if for all $I \in L$, $P(I)$ returns *yes* and for all $I \notin L$, $P(I)$
  either is *undefined* ro $P(I)$ return *no*.

**RECHEABILITY:**  [^3]

**SPACE(f(n)):** [^3] A complexity class with restricted amount of space resource.

**Savitch's Theorem** [^3] A theorem proving $\textbf{NPSAPCE}=\textbf{PSPACE}$. The reduction
overhead is square.

[^1]: [savage1998models](@cite)
[^2]: [maccormick2018can](@cite)
[^3]: [NoC](@cite)
