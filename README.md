# Atomic Counters
 While working on the next generation SoC you were asked to design a 64-bit event counter which would be interfaced with a 32-bit bus controlled via a microcontroller.
 The 64-bit counter is incremented whenever a trigger input is seen.
 Given that the counter is read by a 32-bit bus, a full 64-bit read of the counter needs two 32-bit accesses.
 It is important that these two accesses should be single-copy atomic. 
 Design the 64-bit counter module and the appropriate interfacing mechanism to ensure single-copy atomic counter read operations.
 All the flops should be positive edge triggered with asynchronous resets (if any).

# Interface Definition
trig_i    : Trigger input to increment the counter
req_i     : A read request to the counter
atomic_i  : Marks whether the current request is the first part of the two 32-bit accesses to read
            the 64-bit counter. Use this input to save the current value of the upper 32-bit of
            the counter in-order to ensure single-copy atomic operation
ack_o     : Acknowledge output from the counter
count_o   : 32-bit counter value given as output to the controller

# Interface Requirements
The counter value is read by a 32-bit wide bus but the output should be single-copy atomic. The interface is a simple request and acknowledge interface with the following strict requirements:

Request can be a pulse or can get back to back multiple requests
The acknowledge output must be given one cycle after the request is asserted
The controller will always send two requests in order to read the full 64-bit counter
The first request will always have the atomic_i input asserted
The second request will not have the atomic_i input asserted
