library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registroMEM is 
    generic (
        N : integer := 8
    );
    port(    
        EN   : in  std_logic;
        clk  : in  std_logic;
        D_in : in  std_logic_vector((N-1) downto 0);
        D_out: out std_logic_vector((N-1) downto 0)
    );
end entity registroMEM;

architecture bhv of registroMEM is
    signal reg : std_logic_vector((N-1) downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if EN = '1' then
                reg <= D_in;
            end if;
        end if;
    end process;

    D_out <= reg;
end architecture bhv;
