# Optimization_of_power_beacons
The function OdePoBes  to power a massive IoT network. 

In general, these problems are non-convex and highly nonlinear. Hence, derivative-based methods are prone to converge to a suboptimal solution with an high usage of computational resources. Our proposal is to solve the problem using a heuristic algorithm whose cost scales linearly with the number of PBs.

How to use it?
As we explain in the code files, there are five input parameters:
- number of PBs;
- path loss exponent;
- radius of the service area;
- PB's transmit power ();
- the step size of the iterative search.



## File description:
- OdePoBes (main function) computes the optimal positions of power beacons (PBs);
- optEC/optECoPBC compute the optimal ....;
- rewardEC, rewardECoPBC: ;
- locationsECoPBC, locationsEC: .
