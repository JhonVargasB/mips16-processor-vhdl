library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux is 
	generic(
		N: integer:= 8
	);
	port(
		EN: in std_logic;
		D_in0 : in std_logic_vector ((N-1) downto 0);
		D_in1 : in std_logic_vector((N-1) downto 0);
		D_out: out std_logic_vector((N-1) downto 0)
	);
end mux;


architecture bhv of mux is
begin
	process(EN) begin
		if EN = '1' then
			D_out <= D_in1;
		else		
			D_out <= D_in0; 
		end if;
	end process;
end bhv;
