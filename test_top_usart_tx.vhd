--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:37:24 03/17/2014
-- Design Name:   
-- Module Name:   E:/i2c/test_top_usart_tx.vhd
-- Project Name:  i2c
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top_usart_tx
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_top_usart_tx IS
END test_top_usart_tx;
 
ARCHITECTURE behavior OF test_top_usart_tx IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_usart_tx
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         datain : IN  std_logic_vector(7 downto 0);
         dataready : IN  std_logic;
         txbusy : OUT  std_logic;
         tx : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal datain : std_logic_vector(7 downto 0) := (others => '0');
   signal dataready : std_logic := '0';

 	--Outputs
   signal txbusy : std_logic;
   signal tx : std_logic;
	
--	signal tick : std_logic;
--	signal count : std_logic_vector (3 downto 0):="0000";
--	signal datready : std_logic;

--    Clock period definitions
--   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_usart_tx PORT MAP (
          clk => clk,
          reset => reset,
          datain => datain,
          dataready => dataready,
          txbusy => txbusy,
          tx => tx
        );

--   -- Clock process definitions
--   clk_process :process
--   begin
--		clk <= '0';
--		wait for clk_period/2;
--		clk <= '1';
--		wait for clk_period/2;
--   end process;
-- 
--
--   -- Stimulus process
--   stim_proc: process
--   begin		
--      -- hold reset state for 100 ns.
--      wait for 100 ns;	
--
--      wait for clk_period*10;
--
--      -- insert stimulus here 
--
--      wait;
--   end process;

clk <= not clk after 10 ns;
reset <= '1', '0' after 15 ns;
datain <="11000011", "00001100" after 5 us;
dataready <= '0','1' after 165 ns, '0' after 275 ns, '1' after 5400 ns, '0' after 6 us;





END;
