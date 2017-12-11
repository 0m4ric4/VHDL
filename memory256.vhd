LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

Entity memory256 IS 
port(
D: IN STD_LOGIC_VECTOR (7 downto 0);
address: IN STD_LOGIC_VECTOR (7 downto 0);
clk: IN STD_LOGIC;
memOutput: OUT STD_LOGIC_VECTOR (2047 downto 0);
strobe: OUT STD_LOGIC_VECTOR (2047 downto 0)
);
END memory256;

ARCHITECTURE fati OF memory256 IS 
SIGNAL rowOutput : STD_LOGIC_VECTOR (255 downto 0);

COMPONENT sram_x1 IS
PORT(
  d: IN STD_LOGIC;
  nq: OUT STD_LOGIC;
  strobe: IN STD_LOGIC
 );
END COMPONENT;


COMPONENT decoder256 IS 
port (  A : IN STD_LOGIC_VECTOR (7 downto 0);
       Q: OUT STD_LOGIC_VECTOR (255 downto 0)

);
END COMPONENT;

BEGIN 
--row decoder port map 
d1: decoder256 port map (address,rowOutput);

-- column decoder port map 
process(clk)
begin
for i in 0 to 255 loop 

--checking the row s
	IF (rowOutput(i) = '1' )then
	-- checkinhg for the column 
		FOR j IN 0 to 7 LOOP
			strobe((i*8)+j) <= rowOutput(i);
			--we check if the strobe is 1 or 0
			memOutput((i*8)+j) <= D(j);
			
		END LOOP;   
	END IF;
END loop;
end process; 



END fati;
