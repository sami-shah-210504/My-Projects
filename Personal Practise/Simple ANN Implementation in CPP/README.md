# Simple Artificial Neural Network (ANN) for Logical Functions

This project demonstrates how a simple Artificial Neural Network (ANN) can approximate basic logical functions, such as the **AND** function.

---

## How a Neural Network Works

A neural network is composed of **neurons** (nodes) that process inputs and produce an output using the following basic equation:

$$
z = \sum_{i=1}^{n} w_i x_i + b
$$

where:
- $x_i$ = input values  
- $w_i$ = weights associated with each input  
- $b$ = bias term  
- $z$ = weighted sum (before activation)  

The output of the neuron is then passed through an **activation function**. A commonly used activation is the **sigmoid function**:

$$
\sigma(z) = \frac{1}{1 + e^{-z}}
$$

This function squashes the output between 0 and 1, making it suitable for logical decisions.

---

## Approximating the AND Function

The **AND function** outputs 1 only when both inputs are 1; otherwise, it outputs 0.  
A simple neural network can approximate this by learning appropriate weights and bias.

For two inputs $x_1$ and $x_2$, the neuron output is:

$$
y = \sigma(w_1 x_1 + w_2 x_2 + b)
$$

- If $x_1 = 0$ or $x_2 = 0$, the weighted sum is small, and $\sigma(z)$ ≈ 0.  
- If $x_1 = 1$ and $x_2 = 1$, the weighted sum is large, and $\sigma(z)$ ≈ 1.  

Thus, the network learns to approximate:

| $x_1$ | $x_2$ | AND($x_1, x_2$) |
|-------|-------|-----------------|
|   0   |   0   |        0        |
|   0   |   1   |        0        |
|   1   |   0   |        0        |
|   1   |   1   |        1        |

---

## Key Formulae

1. **Weighted Sum:**
   $$
   z = \sum_{i=1}^{n} w_i x_i + b
   $$

2. **Activation Function (Sigmoid):**
   $$
   \sigma(z) = \frac{1}{1 + e^{-z}}
   $$

3. **Neuron Output:**
   $$
   y = \sigma(w_1 x_1 + w_2 x_2 + b)
   $$

---

## Conclusion

This project shows how even the simplest neural networks can approximate logical functions like AND. With more layers and neurons, ANNs can approximate much more complex relationships.
