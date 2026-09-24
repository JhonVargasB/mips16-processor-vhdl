library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MUX_3to1 is
    Port ( A : in STD_LOGIC_VECTOR(15 downto 0);   -- Entrada 1: vector de 4 bits
           B : in STD_LOGIC_VECTOR(15 downto 0);   -- Entrada 2: vector de 4 bits
           C : in STD_LOGIC_VECTOR(15 downto 0);   -- Entrada 3: vector de 4 bits
           S : in STD_LOGIC_VECTOR(1 downto 0);   -- Señales de selección
           Y : out STD_LOGIC_VECTOR(15 downto 0)   -- Salida: vector de 4 bits
           );
end MUX_3to1;

architecture Behavioral of MUX_3to1 is
begin
    process(A, B, C, S)
    begin
        case S is
            when "00" =>
                Y <= A;  -- Selecciona A
            when "01" =>
                Y <= B;  -- Selecciona B
            when "10" =>
                Y <= C;  -- Selecciona C
            when others =>
                Y <= (others => '0');  -- Estado por defecto
        end case;
    end process;
end Behavioral;
