library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AddrDecoder is
    port(
        MemWrite : in  std_logic;
        Addr     : in  std_logic_vector(4 downto 0);
        WE1      : out std_logic;
        WE2      : out std_logic;
        WEM      : out std_logic;
        RDsel    : out std_logic_vector(1 downto 0)
    );
end AddrDecoder;

architecture bhv of AddrDecoder is 
begin
    process(Addr, MemWrite)
    begin
        -- Valores por defecto
        WE1   <= '0';
        WE2   <= '0';
        WEM   <= '0';
        RDsel <= "00";  -- Por defecto: memoria

        case Addr is
            when "11110" =>  -- Dispositivo de entrada
                RDsel <= "01";
                if MemWrite = '1' then
                    WE1 <= '1';
                end if;

            when "11111" =>  -- Dispositivo de salida
                RDsel <= "10";
                if MemWrite = '1' then
                    WE2 <= '1';
                end if;

            when others =>  -- Memoria
                RDsel <= "00";
                if MemWrite = '1' then
                    WEM <= '1';
                end if;
        end case;
    end process;
end bhv;
