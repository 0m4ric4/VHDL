LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE WORK.ALL;

ENTITY decoder256 IS 
port (  A : IN STD_LOGIC_VECTOR (7 downto 0);
       Q: OUT STD_LOGIC_VECTOR (255 downto 0)

);
END decoder256;

ARCHITECTURE fati OF decoder256 IS 
SIGNAL ENout : STD_LOGIC_VECTOR(15 downto 0);

COMPONENT decoder16 IS 
port ( A, B, C, D, en: IN STD_LOGIC;
output: OUT STD_LOGIC_VECTOR (15 downto 0)

);
END COMPONENT;

BEGIN

	d16 : decoder16 port map (A(7),A(6),A(5),A(4),'1',ENout);
	 
	gen1: 
	for i in 0 to 15 GENERATE 
	

			d0: decoder16 port map (A(3),A(2),A(1),A(0),ENout(i), Q((i*16)+15 downto (i*16)));

	END generate gen1;

 END fati;
