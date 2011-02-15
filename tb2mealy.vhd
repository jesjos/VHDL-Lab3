library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb2mealy is
  port (
    testok : out std_logic := 'H'  
  );
end tb2mealy;

architecture test OF tb2mealy is
  component mealy
    port (
      clk, reset  : in std_logic;
      x           : in std_logic_vector(1 downto 0);
      u           : out std_logic;
      q, qp       : out std_logic_vector(1 downto 0)
    );
  end component;
  signal clk: std_logic := '0';
  signal reset,u : std_logic;
  signal x, q, qp : std_logic_vector(1 downto 0);
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
  tester : process is
  begin
    wait for 150 ns;
    if q /="00" or u/='1' then
      testok <= '0';
      report "Error at time 150";
    end if ;
    wait for 50 ns;
    if q /="00" or u/='1' then
      testok <= '0';
      report "Error at time 200";
    end if ;
    wait for 50 ns;
    if q /="00" or u/='1' then
      testok <= '0';
      report "Error at time 250";
    end if ;
    wait for 50 ns;
    if q /="00" or u/='1' then
      testok <= '0';
      report "Error at time 300";
    end if ;
    wait for 50 ns;
    if q /="01" or u/='1' then
      testok <= '0';
      report "Error at time 350";
    end if ;
    wait for 50 ns;
    if q /="11" or u/='1' then
      testok <= '0';
      report "Error at time 400";
    end if ;
    wait for 50 ns;
    if q /="11" or u/='1' then
      testok <= '0';
      report "Error at time 450";
    end if ;
    wait for 50 ns;
    if q /="10" or u/='1' then
      testok <= '0';
      report "Error at time 150";
    end if ;
    wait;
  end process ; -- tester
end architecture;