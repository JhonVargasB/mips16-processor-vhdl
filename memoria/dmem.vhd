library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity dmem is  -- data memory
    port(
        clk : in std_logic;
        we  : in std_logic;
        a   : in std_logic_vector(4 downto 0);
        wd  : in std_logic_vector(15 downto 0);
        rd  : out std_logic_vector(15 downto 0)
    );
end entity;

architecture behave of dmem is
    type ramtype is array(0 to 31) of std_logic_vector(15 downto 0);
    signal mem : ramtype := (others => (others => '0'));  -- inicializa en cero
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if we = '1' then
                mem(to_integer(unsigned(a))) <= wd;
            end if;
        end if;
    end process;

    rd <= mem(to_integer(unsigned(a)));  -- lectura asíncrona
end architecture;