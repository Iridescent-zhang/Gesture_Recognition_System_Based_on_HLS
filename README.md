# Gesture Recognition System Based on HLS

Gestures as the second language of humans can directly express information and reflect the convenience of interaction. Gesture recognition algorithms usually have the characteristics of high computational complexity and large data processing volume. A solution for the design of two-dimensional gesture interaction based on Field Programmable Gate Array (FPGA) implementation was proposed to effectively improve the operation speed of the algorithm. High-Level Synthesis (HLS) technology was used in this paper to implement the design of the gesture recognition algorithm, greatly accelerating the development time of the algorithm. The IP core synthesized was integrated into the hardware system of FPGA to achieve algorithm hardware acceleration. The main work included the following aspects:
1. The algorithm was implemented according to the HLS design principles for image preprocessing and gesture feature extraction. Verification of the algorithm was performed through simulation, and a RTL design that meets the requirements was obtained by guiding the HLS tool in the synthesis process of the algorithm through the addition of optimization instructions and constraints. 
2. The Zynq SoC 7000 platform from Xilinx, which adopts the ARM+FPGA architecture, was employed. The gesture recognition system was designed based on the concept of software-hardware co-design. The hardware platform was built in the PL (programmable logic) of Zynq, and the program was written in the software development platform Vitis.
3. The recognition of gestures was achieved with high accuracy by utilizing two features, namely effective area ratio and Hu invariant moments, which were extracted. The gesture recognition system's functionality remained stable, and minimal hardware resources were required.

