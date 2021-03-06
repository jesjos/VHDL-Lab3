library ieee ;
  use ieee.std_logic_1164.all ;
  use ieee.numeric_std.all ;

entity genhztest is
end entity ; -- genhztest

architecture arch of genhztest is
  component genhz
    port (
      clk : in std_logic;
      hz1, hz2 : out std_logic    
    );
  end component;
  signal clk : std_logic := '1';   
  signal hz2, hz1 : std_logic;  
begin
  g : genhz PORT MAP (clk, hz1, hz2);
  clk <= not clk after 1 ns;
  p0 : process is
  begin
    wait for 1000000 ns;
    ASSERT hz2 = '1'
    report "first"
    severity failure;
    wait for 1000000 ns;
    assert hz1 = '1'
    report "second"
    severity failure;
  end process ; -- p0
end architecture ; -- arch
