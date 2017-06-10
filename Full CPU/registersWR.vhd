library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity registersWR is
	port(
		RR1,RR2,WR:in STD_LOGIC_VECTOR (4 downto 0);
		WD:in STD_LOGIC_VECTOR (31 downto 0);
		CLK,RegWrite:in STD_LOGIC;
		RD1,RD2:out STD_LOGIC_VECTOR (31 downto 0)
	);
end registersWR;

architecture Behavioral of registersWR is
type twodarray is array(0 to 31) of std_logic_vector(31 downto 0);
signal regcontents:twodarray;

begin
	
	process(CLK)
		variable i,j,k:integer;
		variable flag:boolean:=FALSE;
		begin
			if flag=FALSE then
				regcontents(0)<=(others=>'0');
				regcontents(8)<="00000000000000000000000000000100";
				regcontents(18)<="00000000000000000000000000001101";
				regcontents(19)<="00000000000000000000000000000100";
				flag:=TRUE;
			end if;
			i:=conv_integer(unsigned(RR1));
			j:=conv_integer(unsigned(RR2));
			k:=conv_integer(unsigned(WR));
			if CLK = '0' then
				RD1<=regcontents(i);
				RD2<=regcontents(j);
			elsif CLK = '1' and RegWrite='1' and (k /= 0) then	
				regcontents(k) <= WD;
			end if;
		end process;

end Behavioral;