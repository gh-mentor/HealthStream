"""
This module contains functions for combinatorial calculations.
"""

class Combinatorics:
    @staticmethod
    def fact(n):
        """
        Calculate the factorial of a given number.

        Parameters:
        n (int): The number for which factorial needs to be calculated.

        Returns:
        int: The factorial of the given number.
        """
        if n == 0:
            return 1
        else:
            result = 1
            for i in range(1, n + 1):
                result *= i
            return result

    

