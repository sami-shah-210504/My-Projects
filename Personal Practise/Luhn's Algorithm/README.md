# Luhn’s Algorithm

Luhn’s Algorithm (also known as the "modulus 10" or "mod 10" algorithm) is a simple checksum formula used to validate identification numbers, such as credit card numbers, IMEI numbers, and other government-issued IDs. It helps detect common data entry errors like mistyped or incorrect digits.

The algorithm works by doubling every second digit from the right, subtracting 9 from numbers greater than 9, summing all the digits, and checking if the total is divisible by 10. If it is, the number is considered valid.