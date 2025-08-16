using namespace std;
#include <vector>
#include <iostream>
#include <cmath>
#include <random>
#include <algorithm>

// Simple ANN Implementation in C++
// This code demonstrates a basic single-layer neural network approximating an AND gate.
// Initializing Hardcoded Values for Weights and Biases for a Single Layer Neural Network
const std::vector<double> biases = {0.1, 0.2, 0.3};
const std::vector<std::vector<double>> weights = {
    {0.4, -0.6, 0.1},
    {0.2, 0.8, -0.5},
    {0.5, -0.91, 0.26},
    {-1.5, 0.3, 0.4}
};
// Sigmoid Activation Function
double sigmoid(double x) {
    return 1.0 / (1.0 + exp(-x));
}
// Update Function to Calculate the Output of the Neural Network
std::vector<double> update(const std::vector<double>& inputs) {
    std::vector<double> outputs(biases.size(), 0.0);
    for (size_t i = 0; i < biases.size(); ++i) {
        outputs[i] = biases[i];
        for (size_t j = 0; j < inputs.size(); ++j) {
            outputs[i] += weights[i][j] * inputs[j];
        }
        outputs[i] = sigmoid(outputs[i]);
    }
    return outputs;
}
// Main Function to Demonstrate the Neural Network
int main() {
    std::vector<double> inputs = {1.0, 0.5, -1.5}; // Example input vector
    std::vector<double> outputs = update(inputs); // Get the output from the neural network

    // Print the outputs
    std::cout << "Outputs: ";
    for (const auto& output : outputs) {
        std::cout << output << " ";
    }
    std::cout << std::endl;

    return 0;
}