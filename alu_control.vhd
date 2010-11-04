-- File: alu_control.vhd
-- Generated by MyHDL 0.6
-- Date: Thu Nov  4 02:07:37 2010

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

use work.pck_myhdl_06.all;

entity alu_control is
    port (
        aluop: in unsigned(1 downto 0);
        funct_field: in unsigned(5 downto 0);
        control_out: out unsigned(3 downto 0)
    );
end entity alu_control;

architecture MyHDL of alu_control is


begin


ALU_CONTROL_LOGIC: process (aluop, funct_field) is
begin
    if ((not to_boolean(aluop(0))) and (not to_boolean(aluop(1)))) then
        control_out <= to_unsigned(string'("0010"), 4);
    elsif to_boolean(aluop(0)) then
        control_out <= to_unsigned(string'("0110"), 4);
    elsif to_boolean(aluop(1)) then
        if (bin(funct_field(3-1 downto 0), 4) = string'("0000")) then
            control_out <= to_unsigned(string'("0010"), 4);
        elsif (bin(funct_field(3-1 downto 0), 4) = string'("0010")) then
            control_out <= to_unsigned(string'("0110"), 4);
        elsif (bin(funct_field(3-1 downto 0), 4) = string'("0100")) then
            control_out <= to_unsigned(string'("0000"), 4);
        elsif (bin(funct_field(3-1 downto 0), 4) = string'("0101")) then
            control_out <= to_unsigned(string'("0001"), 4);
        elsif (bin(funct_field(3-1 downto 0), 4) = string'("1010")) then
            control_out <= to_unsigned(string'("0111"), 4);
        else
            control_out <= to_unsigned(0, 4);
        end if;
    end if;
end process ALU_CONTROL_LOGIC;

end architecture MyHDL;