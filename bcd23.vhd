library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity bcd23 is
  port (
    clk, reset, ce : in  std_logic;
    count          : out std_logic_vector(7 downto 0);
    ceo            : out std_logic
    ) ;
end entity ; -- bcd23

architecture arch of bcd23 is
  signal ce2          : std_logic;
  signal loOut, hiOut : std_logic_vector(3 downto 0);
begin
  -- Den minst signifikanta siffran
  lower : process (ce, clk, reset) is
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        loOut <= "0000";
      elsif ce = '1' then
        if (hiOut = "0010" and loOut = "0011") or loOut = "1001" then
          loOut <= "0000";
        else
          loOut <= loOut + 1;
        end if; 
      end if;  -- if reset = 1
    end if;  -- if clock
  end process;

  -- skapar count enable till den mest signifikanta siffran
  ce2 <= '1' when loOut = "1001" or (hiOut = "0010" and loOut ="0011") else '0';

  -- Den mest signifikanta siffran
  upper : process (ce2, clk, reset) is
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        hiOut <= "0000";
      elsif ce2 = '1' then
        if hiOut = "0010" then
          hiOut <= "0000";
        else
          hiOut <= hiOut + 1;
        end if;
      end if;
    end if;
  end process;
  ceo   <= ce when hiOut & loOut = "00000000" else '0';
  count <= hiOut & loOut;
end architecture ; -- arch