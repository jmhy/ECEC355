-- Engineer: Erick Weigel
-- 
-- Create Date: 06/22/2016
-- Design Name: 
-- Module Name: mux5
-- Project Name: MIPS-32 CPU
-- Target Devices: 
-- Tool Versions: 
-- Description: 2-to-1 5-bit multiplexor
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
entity mux5 is
	port(
		-- Input Vectors
		x_5 : in std_logic_vector(4 downto 0);
		y_5 : in std_logic_vector(4 downto 0);
		-- Output Vectors
		z_5 : out std_logic_vector(4 downto 0);
		-- Input Logic
		sel_5 : in std_logic);
end mux5;

-- Behavioral Description
architecture Behavioral of mux5 is
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
-- Map Generic Mux to mux5
MUX1: nMux generic map(5) 
	port map(x => x_5, y => y_5, z => z_5, sel => sel_5);

end Behavioral;