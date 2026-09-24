library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Control_U is
    port(
        Inst : in  std_logic_vector(4 downto 0);
        -- CBus[12:0]:
        -- Jump, RegWrite, MemRead, MemWrite, Branch[2:0],
        -- ALUControl[2:0], ALUSrc, RegSource, FormatSelect
        CBus : out std_logic_vector(12 downto 0)
    );
end Control_U;

architecture bhv of Control_U is
begin
    process(Inst)
    begin
        case Inst is
            when "00000" =>  -- NOP
                CBus <= "0000000000000";

            when "00001" =>  -- ADD
                CBus <= "0100000010001";

            when "00010" =>  -- ADDI
                CBus <= "0100000010110";

            when "00011" =>  -- SUB
                CBus <= "0100000011001";

            when "00100" =>  -- SUBI
                CBus <= "0100000011110";

            when "00101" =>  -- AND
                CBus <= "0100000100001";

            when "00110" =>  -- ANDI
                CBus <= "0100000100110";

            when "00111" =>  -- OR
                CBus <= "0100000101001";

            when "01000" =>  -- ORI
                CBus <= "0100100101110";

            when "01001" =>  -- XOR
                CBus <= "0100000110001";

            when "01010" =>  -- NOT
                CBus <= "0100000001001";

            when "01011" =>  -- SW
                CBus <= "0001000000100";

            when "01100" =>  -- LW
                CBus <= "0110000000100";

            when "01101" =>  -- LD
                CBus <= "0110000000100";

            when "01110" =>  -- ST
                CBus <= "0001000000100";

            when "01111" =>  -- LDI
                CBus <= "0100000000100";

            when "10000" =>  -- MOV
                CBus <= "0100000000001";

            when "10001" =>  -- CLEAR
                CBus <= "0100000000100";

            when "10010" =>  -- JUMP
                CBus <= "1000000000000";

            when "10011" =>  -- BEQ
                CBus <= "0000100011001";

            when "10100" =>  -- BM
                CBus <= "0000010011001";

            when "10101" =>  -- BMI
                CBus <= "0000001011001";

            when others =>
                CBus <= (others => '0');
        end case;
    end process;
end bhv;
