library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Control_U is 
	port(
        --JMP,RegWrite,MemReg, MemW, Branch[3], AluControl[3], AluSrc,Sel
		Inst : in std_logic_vector(4 downto 0);
		CBus : out std_logic_vector(12 downto 0)
		
 --JMP,RegWrite,MemReg, MemW, Branch[3], AluControl[3], AluSrc,Seli,Sel
   );
	
end Control_U;

architecture bhv of Control_U is
begin
	process(Inst) begin
		case Inst is
        
			when "00000" =>  -- ejemplo: instrucción tipo NOP
				CBus <= "0000000000000";  -- aquí tú defines el valor que desees

			when "00001" =>  -- ejemplo: instrucción tipo ADD
				CBus <= "0100000010001";  -- completa tú con bits adecuados

			when "00010" =>  -- ejemplo: instrucción tipo ADDI
				CBus <= "0100000010110";  -- completa tú con bits adecuados				
				
			when "00011" =>  -- ejemplo: instrucción tipo SUB
				CBus <= "0100000011001";  -- completa tú con bits adecuados
			
			when "00100" =>  -- ejemplo: instrucción tipo SUBI
				CBus <= "0100000011110";  -- completa tú con bits adecuados
	
			when "00101" =>  -- ejemplo: instrucción tipo AND
				CBus <= "0100000100001";  -- completa tú con bits adecuados

			when "00110" =>  -- ejemplo: instrucción tipo ANDI
				CBus <= "0100000100110";  -- completa tú con bits adecuados
				
			when "00111" =>  -- ejemplo: instrucción tipo OR
				CBus <= "0100000101001";  -- completa tú con bits adecuados
				
			when "01000" =>  -- ejemplo: instrucción tipo ORI
				CBus <= "0100100101110";  -- completa tú con bits adecuados

			when "01001" =>  -- ejemplo: instrucción tipo XOR
				CBus <= "0100000110001";  -- completa tú con bits adecuados		

			when "01010" =>  -- ejemplo: instrucción tipo NOT
				CBus <= "0100000001001";  -- completa tú con bits adecuados
				
			when "01011" =>  -- ejemplo: instrucción tipo SW Escribir
				CBus <= "0001000000100";  -- completa tú con bits adecuados
				
			when "01100" =>  -- ejemplo: instrucción tipo LW Leer
				CBus <= "0110000000100";  -- completa tú con bits adecuados
				
			when "01101" =>  -- ejemplo: instrucción tipo LD
				CBus <= "0110000000100";  -- completa tú con bits adecuados				
				
			when "01110" =>  -- ejemplo: instrucción tipo ST
				CBus <= "0001000000100";  -- completa tú con bits adecuados
				
			when "01111" =>  -- ejemplo: instrucción tipo LDI
				CBus <= "0100000000100";  -- completa tú con bits adecuados	
				
			when "10000" =>  -- ejemplo: instrucción tipo MOV
				CBus <= "0100000000001";  -- completa tú con bits adecuados

			when "10001" =>  -- ejemplo: instrucción tipo CLEAR
				CBus <= "0100000000100";  -- completa tú con bits adecuados
				
			when "10010" =>  -- ejemplo: instrucción tipo JUMP
				CBus <= "1000000000000";  -- completa tú con bits adecuados
				
			when "10011" =>  -- ejemplo: instrucción tipo BEQ
				CBus <= "0000100011001";  -- completa tú con bits adecuados
				
			when "10100" =>  -- ejemplo: instrucción tipo BM
				CBus <= "0000010011001";  -- completa tú con bits adecuados				
				
			when "10101" =>  -- ejemplo: instrucción tipo BMI
				CBus <= "0000001011001";  -- completa tú con bits adecuados	
				

         when others =>
                CBus <= (others => '0');  -- valor por defecto

        end case;
    end process;
end bhv;
