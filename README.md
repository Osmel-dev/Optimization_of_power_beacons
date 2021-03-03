# Optimization_of_power_beacons
Wireless energy transfer has emerged as a potential candidate for enabling green Internet of Things (IoT) networks. This technology allows to wirelessly recharge IoT devices' batteries with energy from external sources such as dedicated radio frequency transmitters called power beacons (PBs). Herein, the MatLab scripts are used to find the optimal PBs' positions using the Optimal DEployment of POwer BEaconS (Ode-PoBes) algorithm described in [R1].

How to use it?
As we explain in the commented code, the main function OdePoBes receive five parameters:
- number of PBs (scalar or vector);
- path loss exponent (scalar);
- radius of the service area (scalar);
- the step size of the iterative search (scalar).

## File description:
- OdePoBes, which computes the optimal positions of power beacons (PBs). This is the only function that can be used directly, the rest are just auxiliary functions;
- optEC.m/optECoPBC.m, which computes the optimal positions under EC/ECoPBC;
- rewardEC.m/rewardECoPBC.m, which computes the incident power at the minima under EC/ECoPBC;
- locationsECoPBC.m/locationsEC.m, which computes the objective function under EC/ECoPBC;
- simulationDemo.m, which is a demo for testing the OdePoBes algorithm. It computes the optimal PBs' positions for certain number of PBs and propagation conditions.

## References
[R1] O. M. Rosabal, O. L. A. López, H. Alves, S. Montejo-Sánchez and M. Latva-aho, "On the Optimal Deployment of Power Beacons for Massive Wireless Energy Transfer," in IEEE Internet of Things Journal, doi: 10.1109/JIOT.2020.3048065.
