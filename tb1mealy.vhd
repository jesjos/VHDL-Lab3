library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb1mealy is
  port (
    u: out std_logic;
    q, qp : out std_logic_vector(1 downto 0)
  );
end tb1mealy;

architecture test OF tb1mealy is
  component mealy
    port (
      clk, reset  : in std_logic;
      x           : in std_logic_vector(1 downto 0);
      u           : out std_logic;
      q, qp       : out std_logic_vector(1 downto 0)
    );
  end component;
  signal clk: std_logic := '0';
  signal reset : std_logic;
  signal x: std_logic_vector(1 downto 0);
begin  
  u1 : mealy PORT MAP (clk, reset, x, u, q, qp);
  clk <= not clk after 50 ns;
  reset <= '1', '0' after 125 ns;
  -- Testing 00
  x <= 
  "11" after 0 ns,
  "01" after 150 ns,
  "11" after 200 ns,
  "10" after 250 ns,
  "00" after 300 ns,
  -- borde vara i 01
  -- sedan i 11
  -- 11 igen
  "11" after 450 ns,
  -- 10
  "10" after 500 ns,
  -- tillbaka i 00
  "00" after 550 ns,
  -- 01
  "01" after 600 ns,
  -- 00
  "00" after 650 ns,
  -- 01
  "11" after 700 ns,
  -- 00
  "00" after 850 ns,
  -- 01
  "10" after 900 ns,
  -- 00
  "00" after 950 ns,
  -- 01
  -- 11
  "10" after 1050 ns,
  -- 00
  "00" after 1100 ns,
  -- 01
  -- 11
  "01" after 1200 ns,
  -- 00
  "00" after 1250 ns,
  -- 01
  -- 11
  "11" after 1350 ns,
  -- 10
  "01" after 1400 ns,
  -- 00
  "00" after 1450 ns,
  -- 01
  -- 11
  "11" after 1550 ns;
  -- 10
  -- 00
end architecture;
