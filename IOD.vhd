library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IOD is port(
	D_in : in std_logic_vector(15 downto 0);
	D_out : out std_logic_vector(15 downto 0)
);
end IOD;

architecture bhv of IOD is
begin
	D_out <= D_in;
end bhv;

	