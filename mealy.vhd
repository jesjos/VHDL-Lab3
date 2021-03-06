library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mealy is
  port (
    clk, reset : in  std_logic;
    x          : in  std_logic_vector(1 downto 0);
    u          : out std_logic;
    q, qp      : out std_logic_vector(1 downto 0)
    ) ;
end entity;  -- mealy

architecture arch of mealy is
  signal qinner, qpinner : std_logic_vector(1 downto 0);
begin
  clocked : process(clk, reset)
  begin
    if clk = '1' and clk'event then
      if reset = '1' then
        qinner <= "00";
      else
        qinner <= qpinner;
      end if;
    end if;
  end process;  -- clocked
  comb : process(x, qinner)
  begin
    qpinner(0) <= not x(0) and not x(1);
    qpinner(1) <= (qinner(0) and not x(1) and not x(0)) or (qinner(1) and qinner(0) and x(1) and x(0));
    u          <= not (not qinner(0) and not x(0) and x(1) and qinner(1));
  end process;  -- comb

  q <= qinner;
  qp <= qpinner;
end architecture;  -- arch
