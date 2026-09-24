library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AddrDecoder is port(
	MemWrite : in std_logic;
	Addr : in std_logic_vector(4 downto 0);
	WE1,WE2,WEM : out std_logic;
	RDsel : out std_logic_vector(1 downto 0)
	
);
end AddrDecoder;


architecture bhv of AddrDecoder is 
	begin
	process(Addr, MemWrite) begin
		WEM <= '0';
      WE1 <= '0';
		WE2 <= '0';

	if MemWrite = '1' then
		case Addr is

			when "11110" =>  -- 30
				WE1 <= '1';
				RDsel <= "01";
         when "11111" =>  -- 31
				WE2 <= '1';
				RDsel <= "10";
			when others =>
				WEM <= '1';
				RDsel <= "00";
		end case;
	end if;
	end process;
end bhv;
		