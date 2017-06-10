library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;


entity DataMemory is
   port(
      -- Input Logic Vectors
          WriteData		: in std_logic_vector(31 downto 0);
	  MemAddress	        : in std_logic_vector(31 downto 0);
	  -- Input Logic
	  clock			: in std_logic;
	  MemRead		: in std_logic;
	  MemWrite		: in std_logic;
	  -- Output Logic Vectors
	  ReadData:out std_logic_vector(31 downto 0));
end DataMemory;

architecture behavioral of DataMemory is
   -- Create Memory Structure
   type mem is array(0 to 2**8-1) of std_logic_vector(7 downto 0);
   -- Memory Array Signal
   signal memArray:mem;
	begin
   
   -- begin behavioral
   
   process(clock,MemRead,MemWrite,WriteData,MemAddress)
      -- Integer Declarations
          variable i : integer;
	  variable r:integer;
	  -- Boolean Declarations
	  variable flag : boolean := FALSE;
	  variable trigger1 : boolean := FALSE;
	  variable writeNow : boolean := FALSE;
	  
	  -- Begin Initalization Process
	  begin
	     -- Check Flag For Previous Initalization
	     if flag = FALSE then
		    --Initalize Memory Contents
		     
			memArray(4) <= "11111111";
			memArray(5) <= "11111111";
			memArray(6) <= "11111111";
			memArray(7) <= "11111100"; -- negative 4
			memArray(8) <= "11111111";
			memArray(9) <= "11111111";
			memArray(10) <= "11111111";
			memArray(11) <= "11111011"; -- negative 5

			--memArray(4) <= "00000000";
			--memArray(5) <= "00000000";
			--memArray(6) <= "00000000";
			--memArray(7) <= "00000100"; -- positive 4
			--memArray(8) <= "00000000";
			--memArray(9) <= "00000000";
			--memArray(10) <= "00000000";
			--memArray(11) <= "00000101"; -- positive 5	
		
			-- Set Flag
			flag := TRUE;
		end if;
		
		-- Read 32 Bits of Memory
		if MemAddress'event and MemRead='1' and MemAddress/="UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" then 
			r:=conv_integer(unsigned(MemAddress));
			ReadData<=memArray(r)&memArray(r+1)&memArray(r+2)&memArray(r+3);
		end if;

		-- Write 32 Bits of Memory
		if clock = '1' and MemWrite='1' and MemAddress/="UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" then
			if trigger1 = FALSE then
				trigger1 := TRUE;
			elsif writeNow = FALSE then
				writeNow := TRUE;
			
			else 
		      		r:=conv_integer(unsigned(MemAddress));
		      		memArray(r) <= WriteData(31 downto 24);
		      		memArray(r+1) <= WriteData(23 downto 16);
		      		memArray(r+2) <= WriteData(15 downto 8);
		      		memArray(r+3) <= WriteData(7 downto 0);
				trigger1 := FALSE;
				writeNow := FALSE;
			end if;
			
		end if;
		
		
   end process;
end behavioral;