----------------------------------------------------------------------------------
-- Company: Drexel University
-- Engineer: Erick Weigel
-- 
-- Create Date: 06/22/2016
-- Design Name: 
-- Module Name: nMux
-- Project Name: MIPS-32 CPU
-- Target Devices: 
-- Tool Versions: 
-- Description: 2-to-1 n-bit multiplexor
-- 
-- Dependencies: IEEE.STD_LOGIC_1164
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entity Description
entity nMux is
	generic(n:natural:=32);
	port(
		-- Input Vectors
		x : in std_logic_vector(n-1 downto 0);
		y : in std_logic_vector(n-1 downto 0);
		-- Output Vectors
		z : out std_logic_vector(n-1 downto 0);
		-- Input Logic
		sel : in std_logic);
end nMux;

-- Behavioral Description
architecture Behavioral of nMux is
begin

-- Mux Input Select Process
process(x,y,sel)
begin
	-- Select '0' -> X
	if sel = '0' then
		z <= x;
	-- Select '1' -> Y
	elsif sel = '1' then
		z <= y;
	-- Catch All Condition (Shouldn't Occur)
	else
		z <= (others => '0');
	end if;
	
end process;
end Behavioral;