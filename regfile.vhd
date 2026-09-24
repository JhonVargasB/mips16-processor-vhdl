library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-----------------------------------------------------
--En esta parte se define el registro del uP que tiene las siguienters caracteristicas:
--2 puertos de direcciones de lectura ra1,ra2
--1 puertos de direcciones de escritura wa3
--1 señal we3 que habilita la escritura write enable
--wd3 dato de entrada
--rd1,rd2 dato de salida



entity regfile is 
    port(
        clk: in std_logic;                                    
        we3: in std_logic;                                     -- habilitar escritura de datos
        ra1, ra2: in std_logic_vector(2 downto 0);        		-- direcciones de lectura
		  wa3 : in std_logic_vector(2 downto 0);						--direcciones de escritura
		  
		  
        wd3: in std_logic_vector(15 downto 0);                 -- datos para escritura    
        rd1, rd2: out std_logic_vector(15 downto 0)            -- datos para lectura
    );    
end entity;

architecture bhv of regfile is
    type ramtype is array (7 downto 0) of std_logic_vector(15 downto 0);
    signal mem: ramtype := (others => (others => '0'));
	 
begin
    process(clk) 
    begin
        if falling_edge(clk) then
            if we3 = '1' then 
                mem(to_integer(unsigned(wa3))) <= wd3;
            end if;
        end if;
    end process;
    
    -- Lectura combinacional
    process(ra1,ra2,mem) begin
	 
        if to_integer(unsigned(ra1)) = 0 then
            rd1 <= (others => '0');   -- registro 0 fijo en cero
        else 
            rd1 <= mem(to_integer(unsigned(ra1)));
        end if;

		  
        if to_integer(unsigned(ra2)) = 0 then
            rd2 <= (others => '0');
        else 
            rd2 <= mem(to_integer(unsigned(ra2)));
        end if;
		  
		  
    end process;

end bhv;
