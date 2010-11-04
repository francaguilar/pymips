#!/usr/bin/env python
# -*- coding: utf-8 -*-
#

"""
Data Memory
"""

import random 

from myhdl import Signal, delay, always_comb, always, Simulation, \
                  intbv, bin, instance, instances, now, toVHDL



def data_memory(address, write_data, read_data, memread, memwrite ):
    """ Sparse memory model based on a dictionary.

    Ports:

    read_data -- data out
    write_data -- data in
    address -- address bus
    memwrite -- write enable: write if 1, read otherwise
    readwrite -- interface enable: enabled if 1
    """    

    mem = [Signal(intbv(0, min=-(2**31), max=2**31-1)) for i in range(1024)]

    
    @always(memwrite.posedge)
    def write():    
        mem[int(address)].next = write_data.val
    
    @always(memread.posedge)
    def read():        
        read_data.next = mem[int(address)]

    return write, read



def testBench():

    depth = 5

    address = Signal(intbv(0)[32:]) 

    data_in, data_out = [Signal( intbv(0, min=-(2**31),max=2**31-1)) for i in range(2)]

    write_control = Signal(intbv(0)[1:])
    read_control = Signal(intbv(0)[1:])

    memory_i = toVHDL(data_memory, address, data_in, data_out, read_control, write_control)

    addresses = [random.randint(0, 1024) for i in range(depth)]
    values = [random.randint(-(2**31), 2**31-1) for i in range(depth)]

    @instance
    def stimulus():

        #write
        for addr, val in zip(addresses, values):
            
            address.next = intbv( addr)[32:]
            data_in.next = intbv( val, min=-(2**31), max=2**31-1)
            
            write_control.next = 1

            print "Write: addr %i = %d" % ( addr, val)
            yield delay(5)
            write_control.next = 0
            yield delay(5)
        
        #read
        for addr in addresses:
            address.next = intbv( addr)[32:]
            read_control.next = 1
            yield delay(5)
            print "Read: addr %i = %d" % (addr, data_out)
            
            read_control.next = 0
            yield delay(5)
            
    return instances()


def main():
    sim = Simulation(testBench())
    sim.run()

if __name__ == '__main__':
    main()