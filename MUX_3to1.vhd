library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MUX_3to1 is
    Port ( A00 : in STD_LOGIC_VECTOR(15 downto 0);   -- Entrada 1: vector de 4 bits
           B01 : in STD_LOGIC_VECTOR(15 downto 0);   -- Entrada 2: vector de 4 bits
           C10 : in STD_LOGIC_VECTOR(15 downto 0);   -- Entrada 3: vector de 4 bits
           S : in STD_LOGIC_VECTOR(1 downto 0);   -- Señales de selección
           Y : out STD_LOGIC_VECTOR(15 downto 0)   -- Salida: vector de 4 bits
           );
end MUX_3to1;

architecture Behavioral of MUX_3to1 is
begin
    process(A00, B01, C10, S)
    begin
        case S is
            when "00" =>
                Y <= A00;  -- Selecciona A
            when "01" =>
                Y <= B01;  -- Selecciona B
            when "10" =>
                Y <= C10;  -- Selecciona C
            when others =>
                Y <= (others => '0');  -- Estado por defecto
        end case;
    end process;
end Behavioral;
