library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
entity genhz is
  port (
    clk      : in  std_logic;
    hz1, hz2 : out std_logic
    ) ;
end entity;  -- genhz

architecture arch of genhz is
  signal count : std_logic_vector(18 downto 0) := (others => '0');
begin
  p1 : process( clk )
  begin
    if clk='1' and clk'event then
      if count = std_logic_vector(to_unsigned(1000000, 19)) then
        count <= (others => '0');
      else
        count <= count + 1;
      end if ;
    end if ;
  end process ; -- p1
  
  hz1 <= '1' when count = std_logic_vector(to_unsigned(1000000, 19)) or hz2 ='1' else '0';
  hz2 <= '1' when count = std_logic_vector(to_unsigned(500000, 19)) else '0';
end architecture;  -- arch
