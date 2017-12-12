LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE WORK.ALL;

ENTITY main IS 
port (  R0,R1,R2,R3 : INOUT STD_LOGIC_VECTOR (7 downto 0);
       Instruction: IN STD_LOGIC_VECTOR (7 downto 0);
	Clk: IN STD_LOGIC;
	Memory: INOUT STD_LOGIC_VECTOR(2047 downto 0)

);
END main;

ARCHITECTURE behavioral OF main IS 

--strobe
SIGNAL str : STD_LOGIC_VECTOR(2047 downto 0);

COMPONENT memory256 IS 
port(
D: IN STD_LOGIC_VECTOR (7 downto 0);
address: IN STD_LOGIC_VECTOR (7 downto 0);
clk: IN STD_LOGIC;
memOutput: INOUT STD_LOGIC_VECTOR (2047 downto 0);
strobe: OUT STD_LOGIC_VECTOR (2047 downto 0)
);
END COMPONENT;

COMPONENT decoder256 IS 
port (  A : IN STD_LOGIC_VECTOR (7 downto 0);
       Q: OUT STD_LOGIC_VECTOR (255 downto 0)

);
END COMPONENT;

SIGNAL memoryLocation : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL regData: STD_LOGIC_VECTOR(7 downto 0);
SIGNAL decoderOut: STD_LOGIC_VECTOR(255 downto 0);
BEGIN
mem0 : memory256 port map (regData,memoryLocation,Clk,Memory,Str);
dec0 : decoder256 port map (memoryLocation,decoderOut);

process(clk)
begin -- Determine Memory Address + Sign Extention

			
			if Instruction(4) = '0' then -- get from Register
				case(Instruction(3 downto 2)) IS 
					WHEN "00" => 
						memoryLocation <= R0;
					WHEN "01" => --R1
						memoryLocation <= R1;
					WHEN "10" => --R2
						memoryLocation <= R2;
					WHEN OTHERS => --R3
						memoryLocation <= R3;

				end case;
				
			else
				memoryLocation <=  "0000" & Instruction(3 downto 0); -- Sign Extend to 8 bits
				
			end if;
		
		

end process;

process(clk)

begin

if Instruction(7) = '0' then
		
		CASE Instruction(6 downto 5) IS
		WHEN "00" => 
			regData <= R0;
		WHEN "01" => --R1
			regData <= R1;
		WHEN "10" => --R2
			regData <= R2;
		WHEN OTHERS => --R3
			regData <= R3;
		END CASE;
	

else -- load
	for i in 0 to 255 loop 

		--checking the row s
		IF (decoderOut(i) = '1' ) then
			case Instruction(6 downto 5) IS
			WHEN "00" => --R0
				R0 <= Memory((i*8)+7 downto (i*8));
					
			WHEN "01" => --R1
				R1 <= Memory((i*8)+7 downto (i*8));
		
			WHEN "10" => --R2
				R2 <= Memory((i*8)+7 downto (i*8));
		
			WHEN OTHERS => --R3
				R3 <= Memory((i*8)+7 downto (i*8));
			END CASE;
		END IF;
			
	END LOOP;
		
		
end if;


end process;



END behavioral;
