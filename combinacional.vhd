library ieee;
use ieee.std_logic_1164.all;

entity combinacional is
    port (
        Z : in  std_logic;                     
        CMP   : in  std_logic;    
        BranchM  : in std_logic_vector(2 downto 0);    
        JumpM  : in std_logic;
		  PCsrc : out std_logic
    );
end combinacional;

architecture Behavioral of combinacional is
begin
	PCsrc <= (BranchM(0) and Z) or (BranchM(1) and CMP) or(BranchM(2) and (Z or CMP)) or JumpM;
end architecture;
