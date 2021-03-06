-- File: mux2.vhd
-- Generated by MyHDL 0.6
-- Date: Sat Nov 13 12:46:38 2010

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

use work.pck_myhdl_06.all;

entity mux2 is
    port (
        sel: in unsigned(1 downto 0);
        mux_out: out unsigned(31 downto 0);
        chan1: in unsigned(31 downto 0);
        chan2: in unsigned(31 downto 0)
    );
end entity mux2;

architecture MyHDL of mux2 is


begin


MUX2_ROUTE_CHANNEL: process (sel, chan1, chan2) is
begin
    if (sel = 0) then
        mux_out <= chan1;
    else
        mux_out <= chan2;
    end if;
end process MUX2_ROUTE_CHANNEL;

end architecture MyHDL;
