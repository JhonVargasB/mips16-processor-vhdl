library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity uP is port(
	Entrada : in std_logic_vector(15 downto 0);
	Salida : out  std_logic_vector(15 downto 0);
	clk : in std_logic;
	INT0    : in  std_logic;
	INT1    : in  std_logic;
	INT2    : in  std_logic;
	INT3    : in  std_logic;
	INT4    : in  std_logic;
	contadorP : out std_logic_vector(7 downto 0);
	ALU11 :out std_logic_vector(10 downto 0);
	ALU22 :out std_logic_vector(10 downto 0)
	);
end entity;



architecture str of uP is
	component registro 
		generic (
			N : integer
		);
		port(
			clk: in std_logic;
			D_in : in std_logic_vector ((N-1) downto 0);
			D_out : out std_logic_vector((N-1)downto 0)
			);
		end component;

	
	component mux 
		generic(
			N: integer
		);
		port(
			EN: in std_logic;
			D_in0 : in std_logic_vector ((N-1) downto 0);
			D_in1 : in std_logic_vector((N-1) downto 0);
			D_out: out std_logic_vector((N-1) downto 0)
			);
		end component;
	
	component sum port(
      D_in  : in std_logic_vector (7 downto 0);
      D_out : out std_logic_vector (7 downto 0)
		);
	end component;
	
	
	component InterruptHandler is
		port (
			clk     : in  std_logic;
			INT0    : in  std_logic;
			INT1    : in  std_logic;
			INT2    : in  std_logic;
			INT3    : in  std_logic;
			INT4    : in  std_logic;
			selINT  : out std_logic;  -- Señal de selección para el MUX del PC
			PC_out  : out std_logic_vector(7 downto 0)  -- Dirección de la ISR según prioridad
		);
	end component;

	
	component sumb port(
      D_in1  : in std_logic_vector (7 downto 0);
      D_in2  : in std_logic_vector (15 downto 0);
      D_out : out std_logic_vector (15 downto 0)
		);
	end component;
	
	component IMemory port(
		D_out : out std_logic_vector ( 15 downto 0);
		Address : in std_logic_vector( 7 downto 0)
		);
	end component;


	component regfile port(
		clk: in std_logic;                                    
	   we3: in std_logic;                                     -- habilitar escritura de datos
		ra1, ra2: in std_logic_vector(2 downto 0);        		-- read addresses
		wa3 : in std_logic_vector(2 downto 0);						-- write address
		wd3: in std_logic_vector(15 downto 0);                 -- write data    
		rd1, rd2: out std_logic_vector(15 downto 0)            -- read data
		 );    
	end component;


	component ALU port (
      A : in  std_logic_vector(15 downto 0);
      B : in  std_logic_vector(15 downto 0);
      Opcode : in  std_logic_vector(2 downto 0);
      Result : out std_logic_vector(15 downto 0);
		Zero   : out std_logic;
		CMP : out std_logic
		);
	end component;
	
	
	component signex port(
      a : in  STD_LOGIC_VECTOR(7 downto 0);
		y : out STD_LOGIC_VECTOR(15 downto 0)
		);
	end component;

	component memoria port(
		Din : in std_logic_vector(15 downto 0);
		Dout : out std_logic_vector(15 downto 0);
		clk : in std_logic;
		Addr : in std_logic_vector(4 downto 0);
		MemWrite : in std_logic;
		INPUT : in std_logic_vector(15 downto 0);
		OUTPUT : out std_logic_vector(15 downto 0)
		);
	 end component;
	 
	component Control_U
		port(
	-- Control word: Jump, RegWrite, MemRead, MemWrite, Branch, ALUControl, ALUSrc, RegSource, FormatSelect
			Inst : in std_logic_vector(4 downto 0);
			CBus : out std_logic_vector(12 downto 0)
		);
	end component;
	
	component demux8 port (
		Sel : in  std_logic;                       -- selector
      D   : in  std_logic_vector(7 downto 0);    -- entrada de 8 bits
      Y0  : out std_logic_vector(7 downto 0);    -- salida 0
      Y1  : out std_logic_vector(7 downto 0)     -- salida 1
		);
	end component;	

	signal Sel,Seli: std_logic;
	signal Data0,Data1,PC,PCF,PC1,PC1R,PC1RR:  std_logic_vector(7 downto 0);
	signal PC2,PC2R,PC2Mx :  std_logic_vector(15 downto 0);
	signal DIM,DIMR,resultW,RD1,RD2,RD1R,RD2R,RD2RR,SE,SER,SERMx,SRBE,AO,AOR,AORR,RDW,RDWR:  std_logic_vector(15 downto 0);
	signal PCsrcM,Z,ZR,CMP,CMPR,Branch : std_logic;
	signal RegWD,RegWE,RegWM,RegWW : std_logic;
	signal MemRD,MemRE,MemRM,MemRW : std_logic;
	signal MemWD,MemWE,MemWM : std_logic;
	signal JumpD,JumpE,JumpM : std_logic;
	signal BranD,BranE,BranM : std_logic_vector(2 downto 0);
	signal AluCD, AluCE : std_logic_vector(2 downto 0);
	signal AluSD, AluSE : std_logic;
	signal RA2IN,RA1IN,RDR,RDRR : std_logic_vector(2 downto 0);
	signal RDE : std_logic_vector(4 downto 0);
	
	SIGNAL selINT : std_logic;
	SIGNAL PCSOURCE : std_logic_vector(7 downto 0);
	SIGNAL PCINT : std_logic_vector(7 downto 0);
	
begin
	
	unCtr : Control_U 
		port map(
			Inst =>DIMR(15 downto 11),
			CBus(12) => JumpD,
			CBus(11) =>RegWD,
			CBus(10) =>MemRD,
			CBus(9) =>MemWD,
			CBus(8 downto 6) =>BranD,
			CBus(5 downto 3) =>AluCD,
			CBus(2) =>AluSD,
			CBus(1) =>Seli,
			CBus(0) =>Sel
		);
	
	dmux1 : demux8 
		port map(
			Sel => SEL,
			D => DIMR(7 downto 0),  
			Y0 => Data0,
			Y1 => Data1
		);
		
		
		
	regc : registro 
		generic map(N => 8)
		port map(
			clk => clk,
			D_in => PCSOURCE,
			D_out =>PCF
		);
						 
			

			
	sumc : sum 
		port map(
			D_in => PCF,
			D_out => PC1
	  );
	
	muxc : mux 
		generic map(N => 8)
		port map(
			EN =>PCsrcM,
			D_in0 => PC1,
			D_in1 => PC2R(7 downto 0),
			D_out =>PC
		);

		
	INT : InterruptHandler
		port map(
		clk => clk,
		INT0 => INT0,
		INT1 => INT1,
		INT2 => INT2,
		INT3 => INT3,
		INT4 => INT4,
		selINT => selINT,
		PC_out => PCINT
	);



	muxINT : mux 
		generic map(N => 8)
			port map(
			EN => selINT,
			D_in0 => PC,
			D_in1 => PCINT,
			D_out =>PCSOURCE
		);
	

	

	
	IM1  : IMemory 
		port map(
			Address => PCSOURCE,
			D_out => DIM
		);
	
	
	reg1 : registro 
		generic map(N => 24)
		port map(
			clk => clk,
			--Entradas
			D_in(23 downto 8) => DIM,
			D_in(7 downto 0) =>PC1,
			--Salidas
			D_out(23 downto 8) =>DIMR,
			D_out(7 downto 0) =>PC1R
	);
	
	
	regf : regfile 
		port map(
			clk => clk,
			we3 => RegWW,
			ra1 => RA1IN,
			ra2 => RA2IN,
			wa3 => RDRR,
			wd3 => resultW,
			rd1 =>RD1,
			rd2 =>RD2 
		);
	
	sign : signex 
		port map(
			a => Data0,
			y => SE
		);
	
	reg2 : registro 
		generic map(N => 72)
		port map(
			clk => clk,
			--Entradas
			D_in(7 downto 0) => PC1R,
			D_in (23 downto 8) => SE,
			D_in (28 downto 24) => DIMR(10 downto 6),
			D_in (44 downto 29) => RD2,
			D_in (60 downto 45) => RD1,
			D_in(61) => AluSD,
			D_in(64 downto 62) => AluCD,
			D_in(67 downto 65) => BranD,
			D_in(68) => MemWD,
			D_in(69) => MemRD,
			D_in(70) => RegWD,
			D_in(71) => JumpD,
			--Salidas--
			D_out(7 downto 0) => PC1RR, 
			D_out (23 downto 8) => SER,
			D_out (28 downto 24) => RDE,---
			D_out (44 downto 29) => RD2R,
			D_out (60 downto 45) => RD1R,
			D_out(61) => AluSE,
			D_out(64 downto 62) => AluCE,
			D_out(67 downto 65) =>BranE,
			D_out(68) => MemWE,
			D_out(69) => MemRE,
			D_out(70) => RegWE,
			D_out(71) => JumpE
		);
		
		
	sumb1: sumb
		port map(
			D_in1 => PC1RR,
			D_in2 => SERMx,
			D_out=>PC2
		);
	
	muxA : mux 
		generic map(N => 16)
			port map(
			EN => AluSE,
			D_in0 => RD2R,
			D_in1 => SER,
			D_out =>SRBE
		);
	
	alu1 : ALU
		port map(
			A => RD1R,
			B => SRBE,
			Opcode => ALUCE,
			Result =>AO,
			Zero =>Z,
			CMP => CMP
		);
	
	
	reg3 : registro 
		generic map(N => 60)
		port map(
			clk => clk,
			--Entradas
			D_in(15 downto 0) => PC2Mx,
			D_in(18 downto 16) => RDE(4 downto 2),
			D_in (34 downto 19) =>RD2R,
			D_in (50 downto 35) => AO,
			D_in (51) => Z,
			D_in (52) => CMP,
			D_in(55 downto 53)=> BranE,
			D_in(56)=> MemWE,
			D_in(57) =>MemRE,
			D_in(58) =>RegWE,
			D_in(59) =>JumpE,
			--Salidas
			D_out(15 downto 0) => PC2R, 
			D_out (18 downto 16) => RDR,
			D_out (34 downto 19) => RD2RR,
			D_out (50 downto 35) => AOR,
			D_out(51)=> ZR,
			D_out(52)=> CMPR,
			D_out(55 downto 53) =>BranM,
			D_out(56) =>MemWM,
			D_out(57)=>MemRM,
			D_out(58) =>RegWM,
			D_out(59) =>JumpM
		);
	
	mem1 : memoria 
		port map( 
			INPUT => Entrada,
			OUTPUT => Salida,
			clk => clk,
			MemWrite => MemWM,
			Addr=> AOR(4 downto 0),
			Din => RD2RR,
			Dout=> RDW
		);

		
		
		
	reg4 : registro 
		generic map(N => 37)
		port map(
			clk => clk,
			D_in(2 downto 0) => RDR,
			D_in(18 downto 3) => RDW,
			D_in(34 downto 19) =>AOR,
			D_in(35) =>MemRM,
			D_in(36) =>RegWM, 
			D_out(2 downto 0) => RDRR, 
			D_out(18 downto 3) => RDWR,
			D_out(34 downto 19) => AORR,
			D_out(35)=>MemRW,
			D_out(36) =>RegWW
		);
			
			
	muxB : mux 
		generic map(N => 16)
		port map(
			EN => MemRW,
			D_in0 => AORR,
			D_in1 => RDWR,
			D_out =>resultW 
		);
		
		
	muxJmp : mux 
		generic map(N => 16)
		port map(
			EN => JumpE,
			D_in0 => PC2,
			D_in1 => SER,
			D_out =>PC2Mx 
		);
		
		
	muxbranch : mux 
		generic map(N => 16)
		port map(
			EN => Branch,
			D_in0 => SER,
			D_in1 => "00000000000" & RDE,
			D_out =>SERMx 
		);
		
	muxRM : mux 
		generic map(N => 3)
		port map(
			EN => MemWD,
			D_in0 => Data1(2 downto 0),
			D_in1 => DIMR(10 downto 8),
			D_out =>RA2IN
		);

		
	muxRM2 : mux 
		generic map(N => 3)
		port map(
			EN => Seli,
			D_in0 => Data1(5 downto 3),
			D_in1 => DIMR(10 downto 8),
			D_out =>RA1IN
		);
		
		
		
	Branch <= BranE(0) and BranE(1) and BranE(2);
	contadorP <= PCSOURCE;
	ALU11 <= RD1R(10 downto 0);
	ALU22 <= SRBE(10 downto 0);
	PCsrcM <= (BranM(0) and ZR) or (BranM(1) and CMPR) or(BranM(2) and (ZR or CMPR)) or JumpM;
	
end str;

