library ieee ;
  use ieee.std_logic_1164.all ;
  use ieee.numeric_std.all ;

entity drill is
  port (
    clk, start, isDown, isUp, reset : in std_logic;
    motor, lower, step : out std_logic
  ) ;
end entity ; -- drill

architecture arch of drill is
  type states is (s0, s1, s2, s3, s4, s5);
  signal state, nextState : states;
begin
  clocked : process( clk )
  begin
    if clk='1' and clk'event then
      if reset='1' then
        state <= s0;
        nextState <= s0;
      else
        state <= nextState;
      end if;
    end if;
  end process ; -- clocked
  
  comb : process(start, isDown, isUp, state )
  -- s0 => resetläge, vänta på start
  -- s1 => vänta på start = 0 efter inledande startsignal
  -- s2 => starta motor, sänk borret, vänta på "genomslag"
  -- s3 => höj borret, vänta på att borret är i toppläge
  -- s4 => stäng av borren, gå till s0
  begin
    step <= '0';
    case state is
      when s0 =>
        if start='1' then
          nextState <= s1;
        end if;
      when s1 =>
        if start='0' then
          nextState <= s2;
        end if;
      when s2 =>
        motor <= '1';
        lower <= '1';
        if isDown='1' then
          nextState <= s3;
        end if ;
      when s3 =>
        lower <= '0';
        if isUp='1' then
          nextState <= s4;
        end if ;
      when s4 =>
        step <= '1';
        motor <= '0'
    end case ;
  end process ; -- comb
end architecture ; -- arch