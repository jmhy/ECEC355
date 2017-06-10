-- Colby Bennett, Ryan Cunningham, Erick Weigel, Joe Haggerty

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control is
port(Opcode:in std_logic_vector(5 downto 0);
     RegDst,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,Jump:out std_logic;
     ALUOp:out std_logic_vector(1 downto 0));
end Control;


architecture Behavioral of Control is
begin
process(Opcode)
variable temp:std_logic_vector(9 downto 0);
	begin
		if Opcode="000000" then
			temp:="1001000100";
		elsif Opcode="100011" then
			temp:="0111100000";
		elsif Opcode="101011" then
			temp:="U1U0010000";
		elsif Opcode="000100" then
			temp:="U0U0001010";
		elsif Opcode="000010" then
			temp:="1001000001";
		end if;
		RegDst<=temp(9);
		ALUSrc<=temp(8);
		MemtoReg<=temp(7);
		RegWrite<=temp(6);
		MemRead<=temp(5);
		MemWrite<=temp(4);
		Branch<=temp(3);
		ALUOp<=temp(2 downto 1);
		Jump<=temp(0);
	end process;
end Behavioral;
