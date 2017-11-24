LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE WORK.ALL;

ENTITY mux2 IS
PORT (
cmd : IN STD_LOGIC;
i0 : IN STD_LOGIC;
i1 : IN STD_LOGIC;
q : OUT STD_LOGIC
);
END mux2;

ARCHITECTURE RTL of mux2 IS
BEGIN
q <= ( (i1 AND cmd) OR ( NOT(cmd) AND i0)) ;
END RTL;