library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registro is 
    generic (
        N : integer := 8
    );
	port(
		clk: in std_logic;
		D_in : in std_logic_vector ((N-1) downto 0);
		D_out : out std_logic_vector((N-1)downto 0)
	);
end registro;


architecture bhv of registro is
	signal reg : std_logic_vector((N-1) downto 0) := (others => '0');

begin
	process(clk) begin
		if rising_edge(clk) then
			reg <= D_in;
		end if;
		
		D_out <= reg; 
	end process;
end bhv;
