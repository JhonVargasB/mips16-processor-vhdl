library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sum is 
    port(
        D_in  : in std_logic_vector (7 downto 0);
        D_out : out std_logic_vector (7 downto 0)
    );
end sum;

architecture bhv of sum is
begin
    D_out <= std_logic_vector(unsigned(D_in) + 1);
end bhv;
