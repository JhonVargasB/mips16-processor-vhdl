library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port (
        A      : in  std_logic_vector(15 downto 0);
        B      : in  std_logic_vector(15 downto 0);
        Opcode : in  std_logic_vector(2 downto 0);
        Result : out std_logic_vector(15 downto 0);
        Zero   : out std_logic;
		  CMP : out std_logic
    );
end ALU;
architecture Behavioral of ALU is
    signal temp       : unsigned(16 downto 0) := (others => '0');
    signal alu_result : std_logic_vector(15 downto 0);
begin
    process(A, B, Opcode)
    begin
        -- Asignaciones por defecto
        temp       <= (others => '0');
        alu_result <= (others => '0');

        case Opcode is
            when "010" =>  -- ADD
                temp       <= ('0' & unsigned(A)) + ('0' & unsigned(B));
                alu_result <= std_logic_vector(temp(15 downto 0));

            when "011" =>  -- SUB
                temp       <= ('0' & unsigned(A)) - ('0' & unsigned(B));
                alu_result <= std_logic_vector(temp(15 downto 0));

            when "100" =>  -- AND
                -- temp no se usa, pero se asigna para evitar loops
                temp       <= (others => '0');
                alu_result <= A and B;

            when "101" =>  -- OR
                temp       <= (others => '0');
                alu_result <= A or B;

            when "110" =>  -- XOR
                temp       <= (others => '0');
                alu_result <= A xor B;
					 
            when "001" =>  -- NOT
                temp       <= (others => '0');
                alu_result <= not A;
					 
					 
            when "000" =>  -- Tipo I
                temp       <=  ('0' & unsigned(B));
                alu_result <= std_logic_vector(temp(15 downto 0));  -- resultado no se guarda

            when others =>
                temp       <= (others => '0');
                alu_result <= (others => '0');
        end case;

        -- Zero flag
        if alu_result = x"0000" then
            Zero <= '1';
        else
            Zero <= '0';
        end if;
		  
		  --CMP flag
		  CMP <= alu_result(15);  -- MSB indica signo en 2's complement
    end process;

    Result <= alu_result;
end Behavioral;
