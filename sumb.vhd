library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sumb is 
    port(
        D_in1  : in std_logic_vector (7 downto 0);
        D_in2  : in std_logic_vector (15 downto 0);
        D_out : out std_logic_vector (15 downto 0)
    );
end sumb;

architecture bhv of sumb is
begin
    D_out <= std_logic_vector(unsigned(D_in1) + unsigned(D_in2) );
end bhv;
