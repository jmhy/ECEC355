-- Engineer: Erick Weigel
-- 
-- Create Date: 06/22/2016
-- Design Name: 
-- Module Name: mux5
-- Project Name: MIPS-32 CPU
-- Target Devices: 
-- Tool Versions: 
-- Description: 2-to-1 32-bit multiplexor
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
entity mux32 is
	port(
		-- Input Vectors
		x_32 : in std_logic_vector(31 downto 0);
		y_32 : in std_logic_vector(31 downto 0);
		-- Output Vectors
		z_32 : out std_logic_vector(31 downto 0);
		-- Input Logic
		sel_32 : in std_logic);
end mux32;

-- Behavioral Description
architecture Behavioral of mux32 is
	-- nMux Component
	component nMux
		generic(n:natural);
		port(
			-- Input Vectors
			x : in std_logic_vector(n-1 downto 0);
			y : in std_logic_vector(n-1 downto 0);
			-- Output Vectors
			z : out std_logic_vector(n-1 downto 0);
			-- Input Logic
			sel : in std_logic);
	end component;
begin
-- Map Generic Mux to mux32
MUX1: nMux generic map(32) 
	port map(x => x_32, y => y_32, z => z_32, sel => sel_32);

end Behavioral;