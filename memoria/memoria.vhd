library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memoria is port(
	Din : in std_logic_vector(15 downto 0);
	Dout : out std_logic_vector(15 downto 0);
	clk : in std_logic;
	Addr : in std_logic_vector(4 downto 0);
	MemWrite : in std_logic;
	INPUT : in std_logic_vector(15 downto 0);
	OUTPUT : out std_logic_vector(15 downto 0)
);
end memoria;


architecture str of memoria is

	component IOD port(
		D_in : in std_logic_vector(15 downto 0);
		D_out : out std_logic_vector(15 downto 0)
		);
	end component;
	
	component registroMEM     
		generic (
        N : integer
		);
		port(    
        EN   : in  std_logic;
        clk  : in  std_logic;
        D_in : in  std_logic_vector((N-1) downto 0);
        D_out: out std_logic_vector((N-1) downto 0)
		);
	end component;
	
	component AddrDecoder port(
		MemWrite : in std_logic;
		Addr : in std_logic_vector(4 downto 0);
		WE1,WE2,WEM : out std_logic;
		RDsel : out std_logic_vector(1 downto 0)
		);
	end component;
	
	component dmem port(
		clk : in std_logic;
      we  : in std_logic;
      a   : in std_logic_vector(4 downto 0);
      wd  : in std_logic_vector(15 downto 0);
		rd  : out std_logic_vector(15 downto 0)
		);
	end component;
	
	component MUX_3to1 port(	
		A : in STD_LOGIC_VECTOR(15 downto 0);   -- Entrada 1: vector de 4 bits
		B : in STD_LOGIC_VECTOR(15 downto 0);   -- Entrada 2: vector de 4 bits
      C : in STD_LOGIC_VECTOR(15 downto 0);   -- Entrada 3: vector de 4 bits
      S : in STD_LOGIC_VECTOR(1 downto 0);   -- Señales de selección
      Y : out STD_LOGIC_VECTOR(15 downto 0)   -- Salida: vector de 4 bits
       );
	end component;	
	
	signal WE1, WE2 : std_logic;
	signal L00,L01,L10 : std_logic_vector(15 downto 0);
	signal D01,D10 : std_logic_vector(15 downto 0);
	signal RDsel : std_logic_vector(1 downto 0);
	signal WEM : std_logic;
	
begin
	IOD1 : IOD port map(
				D_in => INPUT,
				D_out => D01
			);
	IOD2 : IOD port map(
				D_in => L10,
				D_out => D10
			);
	MUX1 : MUX_3to1 port map(
				A => L00,
				B => D01,
				C => D10,
				S => RDsel,
				Y => Dout
			);
	Mem1 : dmem port map(
				clk => clk,
				we => WEM,
				a => Addr,
				wd => Din,
				rd => L00 
			);
	Reg2 : registroMEM 
			generic map(N => 16)
			port map(
				EN => WE2,
				clk => clk,
				D_in => Din, 
				D_out => L10 
			);
	Deco : AddrDecoder port map(
				MemWrite  => MemWrite,
				Addr  => Addr,
				WE1  => WE1,
				WE2 => WE2,
				WEM => WEM,
				RDsel => RDsel
			);	

	OUTPUT <= D10;
	
end str;
