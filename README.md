# Project
**Due Date: Sunday, Dec. 3, 2017; 11:59PM on Blackboard**
<br>**Presentation Date: TBD**

Team Name:
<br> Team Members: Evan Andre, Ben Hazlett, Stephanie Tam

## Description
**11/28/17 Update:**
<br>Compute _sin(x)_, _cos(x)_~~, _tan(x)_, and _e<sup>x</sup>_~~ of ~~32-bit IEEE-754~~ floating point numbers using the CORDIC algorithm coded with ARM LEGv8. The code will be run using ARMSim. (Note: Integer division doesn't seem to work & hyperbolic stuff is very complicated. See below for extra credit functions and other things.)

**Extra Credit:**
  - division
  - _tan(x)_, _e<sup>x</sup>_, hyperbolic functions (i.e., _sinh(x)_, _cosh(x)_, _tanh(x)_, etc.), etc.
  - IEEE-754 format

## Grading
|Part|Percentage|
|:---|:---:|
|Source Code<ul><li>Comments!</li><li>Reference sources used</li></ul>|30%|
|Oral Presentation<ul><li>Duration: 10 minutes</li><li>Discussion<ul><li>Approach</li><li>Code</li><li>Issues & Solutions</li><li>Results</li><li>Demonstration (use Dayuan's numbers)</li></ul></li></ul>|30%|
|Final Report <i>(for each cycle)</i><ul><li>Total computer cycles</li><li>Estimated CPI</li><li>Estimated total processing time, assuming system clock of 32kHz, 1MHz, and 1GHz</li><li>Description of implemented algorithms</li><li>Sample input and output</li></ul>|30%|
|Peer Review|10%|

## Final Report
**Total Computer Cycles**
<br>

**Estimated CPI**
<br> CPI = # of instructions

**Estimated Total Processing Time** (assume system clock of:)
  - 32kHz: 
  - 1MHz: 
  - 1GHz: 

<br>**Description of Implemented Algorithms**
<br> To calculate _sin(x)_ and _cos(x)_ we used the CORDIC algorithm.

In implementing division in ARM LEGv8, 

<br>**Sample Input & Output**

|Angle, _z_|_cos(z)_ Hexadecimal|_sin(z)_ Hexadecimal|_cos(z)_ Approx.|_sin(z)_ Approx.|
|:---:|:---:|:---:|:---:|:---:|
|5.2954|0000.fee3|0000.17be|0.9956512|0.0927429|
|80.1|0000.2c0a|0000.fc2e|0.1720275|0.9850769|
|24.23|0000.e989|0000.68d4|0.9122467|0.4094848|
|48.52|0000.a96f|0000.bfe9|0.6618499|0.7496490|
|10.001|0000.fc17|0000.2c88|0.9847259|0.1739501|
|70.86159|0000.53f1|0000.f1d5|0.3278961|0.9446563|
|30.0|0000.ddbd|0000.7ff0|0.8661651|0.4997558|
|86.5|.0b043615|.efe84526|0.0430330|0.9371379|
|90|00000000|00000001|0|1|
|0|00000001|00000000|1|0|

<br>**Resources:**
- CMSC 411, Lecture Slides 12_Algorithms, Slide 50 (C code)
- [CORDIC for Dummies](http://bsvi.ru/uploads/CORDIC--_10EBA/cordic.pdf)
- [Using ARMsim](http://armsim.cs.uvic.ca/AttachedFiles/ARMSim_UserGuide4Plus.pdf)
- [ARM InfoCenter](http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0204j/index.html)
- [Division in ARM](http://www.tofla.iconbar.com/tofla/arm/arm02/index.htm)
- https://github.com/Maximell/Cordic
- [Hexadecimal to Decimal](https://www.rapidtables.com/convert/number/hex-to-decimal.html)
