library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux8 is
    port (
        sel : in  std_logic;                       -- selector
        D   : in  std_logic_vector(7 downto 0);    -- entrada de 8 bits
        Y0  : out std_logic_vector(7 downto 0);    -- salida 0
        Y1  : out std_logic_vector(7 downto 0)     -- salida 1
    );
end entity;

architecture Behavioral of demux8 is
begin
    process(sel, D)
    begin
        if sel = '0' then
            Y0 <= D;
            Y1 <= (others => '0');
        else
            Y0 <= (others => '0');
            Y1 <= D;
        end if;
    end process;
end architecture;
