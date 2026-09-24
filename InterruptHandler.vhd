library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity InterruptHandler is
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
end entity;

architecture Behavioral of InterruptHandler is
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if INT0 = '1' then
                PC_out <= "10101111";-- 175
                selINT <= '1';
            elsif INT1 = '1' then
                PC_out <= "11000001";-- 193
                selINT <= '1';
            elsif INT2 = '1' then
                PC_out <= "11010000";-- 210
                selINT <= '1';
            elsif INT3 = '1' then
                PC_out <= "11011111";-- 225
                selINT <= '1';
            elsif INT4 = '1' then
                PC_out <= "11101110";--240
                selINT <= '1';
            else
                selINT <= '0';  -- ninguna interrupción activa
            end if;
        end if;
    end process;
end Behavioral;