library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- 8 x 16-bit register file.
-- Two asynchronous read ports and one synchronous write port.
-- Register 0 is hardwired to zero on reads.

entity regfile is
    port(
        clk      : in  std_logic;
        we3      : in  std_logic;                     -- write enable
        ra1, ra2 : in  std_logic_vector(2 downto 0); -- read addresses
        wa3      : in  std_logic_vector(2 downto 0); -- write address
        wd3      : in  std_logic_vector(15 downto 0);-- write data
        rd1, rd2 : out std_logic_vector(15 downto 0) -- read data
    );
end entity;

architecture bhv of regfile is
    type ramtype is array (7 downto 0) of std_logic_vector(15 downto 0);
    signal mem : ramtype := (others => (others => '0'));
begin
    process(clk)
    begin
        if falling_edge(clk) then
            if we3 = '1' then
                mem(to_integer(unsigned(wa3))) <= wd3;
            end if;
        end if;
    end process;

    -- Asynchronous reads.
    process(ra1, ra2, mem)
    begin
        if to_integer(unsigned(ra1)) = 0 then
            rd1 <= (others => '0');
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
