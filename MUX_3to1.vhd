library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MUX_3to1 is
    Port ( A00 : in STD_LOGIC_VECTOR(15 downto 0);   -- 16-bit input A
           B01 : in STD_LOGIC_VECTOR(15 downto 0);   -- 16-bit input B
           C10 : in STD_LOGIC_VECTOR(15 downto 0);   -- 16-bit input C
           S : in STD_LOGIC_VECTOR(1 downto 0);   -- Select
           Y : out STD_LOGIC_VECTOR(15 downto 0)   -- 16-bit output
           );
end MUX_3to1;

architecture Behavioral of MUX_3to1 is
begin
    process(A00, B01, C10, S)
    begin
        case S is
            when "00" =>
                Y <= A00;
            when "01" =>
                Y <= B01;
            when "10" =>
                Y <= C10;
            when others =>
                Y <= (others => '0');  -- default
        end case;
    end process;
end Behavioral;
