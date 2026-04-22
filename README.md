# NE411: Xe-135 Poisoning and Reactor Deadtime Simulation

## 📌 Project Overview
This repository contains a MATLAB simulation for **NE411 Assignment 1**, focusing on Xenon-135 (Xe-135) poisoning dynamics after a nuclear reactor shutdown. The script calculates equilibrium concentrations, tracks reactivity changes over time, identifies peak poisoning, and determines the reactor's "Deadtime."

## 🚀 Features
- **Equilibrium Calculation:** Verifies initial $N_I$ and $N_{Xe}$ concentrations at steady-state operation.
- **Reactivity Tracking:** Converts Xe-135 concentration into reactivity (in dollars $) over a 50-hour period.
- **Critical Event Detection:** Automatically calculates the peak reactivity and the exact duration of the reactor deadtime based on a 9.0 $ control rod limit.
- **Data Visualization:** Generates a comprehensive plot comparing analytical curves with specific data points, highlighting the deadtime region.

## 📊 Results & Output
The simulation generates the following analytical report in the command window:

```text
====================================================
          Xe-135 POISONING ANALYSIS REPORT          
====================================================

>>> PART A: Equilibrium Concentrations <<<
----------------------------------------------------
 - N_I_eq  = 3.3397e+16 atoms/cm^3
 - N_Xe_eq = 6.5785e+15 atoms/cm^3
 * Status: Matches initial data at t=0 (Equilibrium Confirmed).

>>> PART B: Reactivity vs. Time <<<
----------------------------------------------------
   Time (hours)  |   Reactivity ($)   
----------------------------------------------------
       00        |       3.625        
       02        |       6.298        
       04        |       8.006        
       06        |       8.992        
       08        |       9.450        
       10        |       9.521        
       12        |       9.323        
       14        |       8.943        
       16        |       8.441        
       18        |       7.868        
       20        |       7.268        
       25        |       5.758        
       30        |       4.413        
       40        |       2.432        
       50        |       1.271        
----------------------------------------------------

>>> CRITICAL EVENT RESULTS <<<
----------------------------------------------------
 - Maximum Reactivity (Peak) : 9.521 $
 - Time of Peak Reactivity   : 10 hours
----------------------------------------------------
 - Deadtime Start Time       : 6.03 hours
 - Deadtime End Time         : 13.70 hours
 - Total Deadtime Duration   : 7.67 hours
====================================================
```

📈 Visual Simulation (Reactivity Curve)
The following graph visualizes the Xe-135 poisoning curve, highlighting the analytical model, the exact data points, and the shaded deadtime region where reactivity exceeds the control rod limit.

🛠️ Usage
Clone the repository.

Open the main script in MATLAB.

Run the script. The output will print directly to the command window, and the plot will be saved automatically as Xe135_Reactivity_Deadtime.png in the current directory.
