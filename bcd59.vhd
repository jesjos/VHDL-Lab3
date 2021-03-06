library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
entity bcd59 is
  port (
    clk, ce, reset : in  std_logic;
    count          : out std_logic_vector(7 downto 0);
    ceo            : out std_logic
    ) ;
end entity;  -- bcd59

architecture arch of bcd59 is
  signal ce2, ce2next         : std_logic;
  signal loOut, hiOut : std_logic_vector(3 downto 0);
begin
  -- Den minst signifikanta siffran
  lower : process (ce, clk, reset) is
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        loOut <= "0000";
      elsif ce = '1' then
        if loOut = "1001" then
          loOut <= "0000";
        else
          loOut <= loOut + 1;
        end if;  -- if loOut = 0
      end if;  -- if reset = 1
    end if;  -- if clock
  end process;
  
  ce2 <= '1' when loOut = "1001" else '0';
  
  -- Den mest signifikanta siffran
  upper : process (ce2, clk, reset) is
  begin
    if clk'event and clk = '1' then
      if reset = '1' then
        hiOut <= "0000";
      elsif ce2 = '1' then
        if hiOut = "0101" then
          hiOut <= "0000";
        else
          hiOut <= hiOut + 1;
        end if;
      end if;
    end if;
  end process;
  ceo   <= ce when hiOut & loOut = "01011001" else '0';
  count <= hiOut & loOut;
end architecture;  -- arch
