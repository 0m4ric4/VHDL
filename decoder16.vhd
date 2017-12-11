LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE WORK.ALL;

ENTITY decoder16 IS 
port ( A,B, C, D,en: IN STD_LOGIC;
output: OUT STD_LOGIC_VECTOR (15 downto 0)

);
END decoder16;

ARCHITECTURE fati OF decoder16 IS 
SIGNAL m: STD_LOGIC_VECTOR (29 downto 0);
SIGNAL s: STD_LOGIC_VECTOR (3 downto 0);
Signal x: STD_LOGIC_VECTOR (15 downto 0);
COMPONENT inv_x2 IS
PORT(
  i: IN STD_LOGIC;
  nq: OUT STD_LOGIC
);
END COMPONENT;
COMPONENT a2_x2 IS
PORT(
  i0: IN STD_LOGIC;
  i1: IN STD_LOGIC;
  q: OUT STD_LOGIC
);
END COMPONENT;
BEGIN 

 notA: inv_x2 port map (A, S(0));
 notB: inv_x2 port map (B, S(1));
 notC: inv_x2 port map (C, S(2));
 notD: inv_x2 port map (D, S(3));
 
 A0: a2_x2 port map (S(0), S(1), m(0));
 A1: a2_x2 port map (S(0), B, m(1));
 A2: a2_x2 port map (A, S(1), m(2));
 A3: a2_x2 port map (A, B, m(3)); 
 
 A4: a2_x2 port map (S(2), S(3), m(4));
 A5: a2_x2 port map (S(2), D, m(5));
 A6: a2_x2 port map (C, S(3), m(6));
 A7: a2_x2 port map (C, D, m(7));
 
f_gen: 
for i in 0 to 3 GENERATE 
m_gen:
for j IN 0 to 3 GENERATE 

andgate: a2_x2 port map (m(i), m(j+4), x(j + i*4));

END generate m_gen;
End generate f_gen;
 output <= "0000000000000000" when en ='0' else x;
 END fati;
