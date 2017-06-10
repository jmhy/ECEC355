library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ShiftLeft2Jump is
	generic(n:natural:=32);
	port(
		x:in std_logic_vector(n-7 downto 0);
		y:in std_logic_vector(3 downto 0);
		z:out std_logic_vector(n-1 downto 0)
	);
end ShiftLeft2Jump;

architecture Behavioral of ShiftLeft2Jump is
    begin
    z <= y & x & "00";
end Behavioral;