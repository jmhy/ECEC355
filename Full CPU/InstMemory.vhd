-- Colby Bennett

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;

entity InstMemory is
port(Address:in std_logic_vector(31 downto 0);
     ReadData:out std_logic_vector(31 downto 0));
end InstMemory;

architecture Behavioral of InstMemory is
type memarray is array(0 to 2**8-1) of std_logic_vector(7 downto 0);
signal memcontents:memarray; 
begin
process(Address)
    variable i,j:integer;
    begin
    -- lw  $s5,0($t0)
        memcontents(0) <= "10001101";
        memcontents(1) <= "00010101";
        memcontents(2) <= "00000000";
        memcontents(3) <= "00000000";
    -- lw  $s6,4($t0)
        memcontents(4) <= "10001101";
        memcontents(5) <= "00010110";
        memcontents(6) <= "00000000";
        memcontents(7) <= "00000100";
    -- slt $t7,$s5,$s6
        memcontents(8) <= "00000010";
        memcontents(9) <= "10110110";
        memcontents(10) <= "01111000";
        memcontents(11) <= "00101010";
    -- beq $t7,$zero,L
        -- L is relative to how far the L code is from the NEXT line down
        -- in this case, L is 2 lines from the next line down, being the "sub" line, so L=00000010
        memcontents(12) <= "00010001";
        memcontents(13) <= "11100000";
        memcontents(14) <= "00000000";
        memcontents(15) <= "00000010";
    -- sub $s1,$s2,$s3
        memcontents(16) <= "00000010";
        memcontents(17) <= "01010011";
        memcontents(18) <= "10001000";
        memcontents(19) <= "00100010";
    -- j exit
    -- 7 lines from begin line, hence 00000111 in last mem contents spot
        memcontents(20) <= "00001000";
        memcontents(21) <= "00000000";
        memcontents(22) <= "00000000";
        memcontents(23) <= "00000111";
    
    -- L: add $s1,$s2,$s3
        memcontents(24) <= "00000010";
        memcontents(25) <= "01010011";
        memcontents(26) <= "10001000";
        memcontents(27) <= "00100000";
    
    -- exit:  sw $s1,12($t0)
        memcontents(28) <= "10101101";
        memcontents(29) <= "00010001";
        memcontents(30) <= "00000000";
        memcontents(31) <= "00001100";
      
		
		j := conv_integer(unsigned(Address));
    ReadData <= memcontents(j) & memcontents(j+1) & memcontents(j+2) & memcontents(j+3);
    
    end process;
    
end Behavioral;
