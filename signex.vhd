library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity signex is  -- sign extender
    port(
        a : in  STD_LOGIC_VECTOR(7 downto 0);
        y : out STD_LOGIC_VECTOR(15 downto 0)
    );
end entity;

architecture bhv of signex is
begin
    y <= (7 downto 0 => a(7)) & a;  -- extensión manual del bit de signo
end bhv;

