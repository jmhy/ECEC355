-- Colby Bennett, Joe Haggerty, Erick Weigel, Ryan Cunningham

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU is
  port(clk:in std_logic; Overflow:out std_logic);
end CPU;

architecture struc of CPU is


component ALU is
generic(n:natural:=32);
port(a,b:in std_logic_vector(n-1 downto 0);
	  Oper:in std_logic_vector(3 downto 0);
	  Result:buffer std_logic_vector(n-1 downto 0);
	  Zero,Overflow:buffer std_logic);
 end component;

component ALUControl is
port(ALUOp:in std_logic_vector(1 downto 0);
     Funct:in std_logic_vector(5 downto 0);
     Operation:out std_logic_vector(3 downto 0));
end component;

component And2 is
    port(x,y:in std_logic;z:out std_logic);
end component;

component Control is
port(Opcode:in std_logic_vector(5 downto 0);
     RegDst,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,Jump:out std_logic;
     ALUOp:out std_logic_vector(1 downto 0));
end component;

component DataMemory is
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
end component;

 component InstMemory is
port(Address:in std_logic_vector(31 downto 0);
     ReadData:out std_logic_vector(31 downto 0));
end component;

component mux5 is
	port(
		-- Input Vectors
		x_5 : in std_logic_vector(4 downto 0);
		y_5 : in std_logic_vector(4 downto 0);
		-- Output Vectors
		z_5 : out std_logic_vector(4 downto 0);
		-- Input Logic
		sel_5 : in std_logic);
end component;

component mux32 is
	port(
		-- Input Vectors
		x_32 : in std_logic_vector(31 downto 0);
		y_32 : in std_logic_vector(31 downto 0);
		-- Output Vectors
		z_32 : out std_logic_vector(31 downto 0);
		-- Input Logic
		sel_32 : in std_logic);
end component;

component registersWR is
	port(
		RR1,RR2,WR:in STD_LOGIC_VECTOR (4 downto 0);
		WD:in STD_LOGIC_VECTOR (31 downto 0);
		CLK,RegWrite:in STD_LOGIC;
		RD1,RD2:out STD_LOGIC_VECTOR (31 downto 0)
	);
end component;

component ShiftLeft2Jump is
	generic(n:natural:=32);
	port(
		x:in std_logic_vector(n-7 downto 0);
		y:in std_logic_vector(3 downto 0);
		z:out std_logic_vector(n-1 downto 0)
	);
end component;

component ShiftLeft2 is
    generic(
		n:natural:=32;
		k:natural:=2
	);
    port(
        x:in std_logic_vector(n-1 downto 0);
        y:out std_logic_vector(n-1 downto 0)
    );
end component;

component SignExtend is
	generic(n:natural:=16);
	port(
		x:in std_logic_vector(n-1 downto 0);
		y:out std_logic_vector(2*n-1 downto 0)
	);
end component;

component PC is
	generic (n:natural:=32);
	port(CLK:in std_logic;
		  AddressIn:in std_logic_vector(n-1 downto 0);
		  AddressOut:out std_logic_vector(n-1 downto 0));
end component;



  -- Various signals
  signal A,C,D,E,F,G,H,J,K,L,M,N,P,Q:STD_LOGIC_VECTOR(31 downto 0);
  signal B:STD_LOGIC_VECTOR(4 downto 0);
  signal R:STD_LOGIC;

  -- Full 32-bit instruction
  signal Instruction:STD_LOGIC_VECTOR(31 downto 0);

  -- Out of ALU control
  signal Operation:STD_LOGIC_VECTOR(3 downto 0);

  -- Control out
  signal RegDst,Branch,MemRead,MemtoReg,MemWrite,ALUSrc,RegWrite,Jump,Zero:STD_LOGIC;
  signal ALUop:STD_LOGIC_VECTOR(1 downto 0);
  signal four:STD_LOGIC_VECTOR(31 downto 0):="00000000000000000000000000000100";
  
begin     
  PC_0: PC port map(clk,P,A);
  IM: InstMemory port map(A,Instruction);
  Control_0: Control port map(Instruction(31 downto 26),RegDst,Branch,MemRead,MemToReg,MemWrite,ALUSrc,RegWrite,Jump,ALUop);
  ALUControl_0: ALUControl port map(ALUop,Instruction(5 downto 0),Operation);
  Mux5_0:mux5 port map(Instruction(20 downto 16),Instruction(15 downto 11),B,RegDst);
  Reg:registersWR port map(Instruction(25 downto 21),Instruction(20 downto 16),B,J,clk,RegWrite,C,D);
  SignExt:SignExtend port map(Instruction(15 downto 0),E);
  Mux32_0:mux32 port map(D,E,F,ALUSrc);
  ALU_0:ALU port map(C,F,Operation,G,Zero,Overflow);
  DM:DataMemory port map(D,G,clk,MemRead,MemWrite,H);
  Mux32_1:mux32 port map(G,H,J,MemtoReg);
  ADD4:ALU port map(A,four,"0010",L,open,open);
  SLLJ:ShiftLeft2Jump port map(Instruction(25 downto 0),L(31 downto 28),Q);
  SLLALU:ShiftLeft2 port map(E,K);
  ADD:ALU port map(L,K,"0010",M,open,open);
  AND_0:And2 port map(Branch,Zero,R);
  MuxPC_0:mux32 port map(L,M,N,R);
  MuxPC_1:mux32 port map(N,Q,P,jump);
  
end struc;
