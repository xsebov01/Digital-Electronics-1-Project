# Parking assistant with HC-SR04 ultrasonic sensor, sound signaling using PWM, signaling by LED bargraph

### Team members

* Mikhail Smolnikov
* Jakub Soboňa  
* Richard Stupka 
* Dušan Sýkora  
* Vladimíra Šebová 

[GitHub project folder](https://github.com/prostmich/Digital-Electronics-1-Project)

### Project objectives

The main goal of the project is to create a parking assistant program that will primarily use the HC-SR04 sensor to measure the distance from the objects. In cooperation with it, it will also use PWM sound signaling, the sound of which will be escalated by the approaching object. Last but not least, we will also use LEDs built into our used Arty A7-35T board. The improvement of our project is a 4 digit 7 segment display, which will display the distance from the object in centimeters.

## Hardware description
**Board:** Arty A7-35T

![Board](images/board.png)

| Callout | Description | Callout | Description | Callout | Description |
| :-: | :-: | :-: | :-: | :-: | :-: |
| 1 | FPGA programming DONE LED | 8 | User RGB LEDs | 15 | chipKIT processor reset |
| 2 | Shared USB JTAG/UART port | 9 | User slide switches | 16 | Pmod connectors |
| 3 | Ethernet connector | 10 | User push buttons | 17 | FPGA programming reset button |
| 4 | Mac address sticker | 11 | Arduino/chipKIT shield connectors | 18 | SPI flash memory |
| 5 | Power jack for optional external supply | 12 | Arduino/chipKIT shield SPI connectors | 19 | Artix FPGA |
| 6 | Power good LED | 13 | chipKIT processor reset jumper | 20 | Micron DDR3 memory |
| 7 | User LEDs | 14 | FPGA programming mode | 21 | Dialog Semiconductor DA9062 power supply |

**Pins from board**

![Pins](images/pins.png)

**Board connection table**

|  | Pmod JA | Pmod JB | Pmod JC | Pmod JD |
| :-: | :-: | :-: | :-: | :-: |
| Pmod Type | Standard | High-Speed | High-Speed | Standard |
| Pin 1 | G13 | E15 | U12 | D4 |
| Pin 2 | B11 | E16 | V12 | D3 |
| Pin 3 | A11 | D15 | V10 | F4 |
| Pin 4 | D12 | C15 | V11 | F3 |
| Pin 7 | D13 | J17 | U14 | E2 |
| Pin 8 | B18 | J18 | V14 | D2 |
| Pin 9 | A18 | K15 | T13 | H2 |
| Pin 10 | K16 | J15 | U13 | G2 |

**Sensor:** HC-SR04 ultrasonic sensor

![Sensor](images/sensor.jpg)

![Sensor functionality](https://lastminuteengineers.com/wp-content/uploads/arduino/HC-SR04-Ultrasonic-Sensor-Working-Echo-reflected-from-Obstacle.gif)

**Sensor connection table**

| Sensor Pin | Board Pin |
| :-: | :-: | 
| VCC | VCC | 
| Trig | G13 | 
| Echo | D13 | 
| GND | GND | 

**Electric parameter of sensor**

| Parameter | Value |
| :-: | :-: | 
| Working Voltage | DC 5V | 
| Working Current | 15mA | 
| Working Frequency | 40Hz | 
| Max Range | 4m | 
| Min Range | 2cm |
| Measuring Angle | 15 degree |
| Trigger Input Signal | 10uS TTL pulse |
| Echo Output Signal | Input TTL lever signal and the range proportion |
| Dimension | 45*20*15mm |


**Display:** 4 digit 7 segment display

![Display](images/display.png)

**Display connection table**
| Display Pin | Board Pin (General) |
| :-: | :-: |
| CLK | B11 | 
| VCC | VCC | 
| GND | GND | 

| Display Pin | Board Pin (Anode) |
| :-: | :-: | 
| E15 | AN0 | 
| E16 | AN1 | 
| D15 | AN2 | 
| C15 | AN3 | 

| Display Pin | Board Pin (Cathode) |
| :-: | :-: | 
| U12 | CA | 
| V12 | CB | 
| V10 | CC | 
| V11 | CD | 
| U14 | CE | 
| V14 | CF | 
| T13 | CG | 


## VHDL modules description and simulations

**Distance calculation**

Calculates distances based on received pulses from the HC-SR04 sensor.
The output is a 9-bit signal, representing the distance of the object from the sensor.

**Pulse counter**

Counts how many pulses were received. This number is used for further distance calculation.

**Trigger generator**

Generates pulses that are used to determine when the distance will be calculated.
The pulse generation interval is set to 250ms.

**Binary to distance converter**

Converts the binary signal from the "Distance Calculation" module to certain distance units.
The output value is divided into hundreds, tens, units of centimeters.

**Seven segment display driver**

This module, added by us, is designed to convert the distance to a signal, which is sent to an external display.
We use only the last three digits, the first is always "0" because we do not need to show a distance value greater than 400 centimeters.

**Binary to bargraph driver**

This module converts the calculated distance value to a certain number of lit LEDs.

Conditions for lighting of individual LED diodes are:
| Range | Number of LEDs |
| :-: | :-: | 
| 0cm — 5cm | 4 |
| 6cm — 9cm | 3 | 
| 10cm — 50cm | 2 | 
| 51cm — 250cm | 1 | 
| 251cm +  | 0 |

**Pulse-width modulator**

This module generates a rectangular signal of a certain frequency, which we then modulate depending on the distance of the object from the sensor.
The closer the object, the more frequent the alarm.

## TOP module description and simulations

Write your text here.


## Video

*Write your text here*


## References

   * [Arty A7 Reference Manual](https://reference.digilentinc.com/reference/programmable-logic/arty-a7/reference-manual)
   * [Arty A7 Schematic Prints](https://reference.digilentinc.com/_media/reference/programmable-logic/arty-a7/arty_a7_sch.pdf)
   * [Ultrasonic Ranging Module HC-SR04 Datasheet](https://cdn.sparkfun.com/datasheets/Sensors/Proximity/HCSR04.pdf)
   * [HC-SR04 Ultrasonic Sensor Tutorial](https://lastminuteengineers.com/arduino-sr04-ultrasonic-sensor-tutorial)
