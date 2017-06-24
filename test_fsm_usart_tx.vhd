--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:49:19 03/17/2014
-- Design Name:   
-- Module Name:   E:/i2c/test_fsm_usart_tx.vhd
-- Project Name:  i2c
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: fsm_usart_tx
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_fsm_usart_tx IS
END test_fsm_usart_tx;
 
ARCHITECTURE behavior OF test_fsm_usart_tx IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fsm_usart_tx
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         datready : IN  std_logic;
         tick : IN  std_logic;
         count : IN  std_logic_vector(3 downto 0);
         txbusy : OUT  std_logic;
         iden : OUT  std_logic;
         shen : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal datready : std_logic := '0';
   signal tick : std_logic := '0';
   signal count : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal txbusy : std_logic;
   signal iden : std_logic;
   signal shen : std_logic;


 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fsm_usart_tx PORT MAP (
          clk => clk,
          reset => reset,
          datready => datready,
          tick => tick,
          count => count,
          txbusy => txbusy,
          iden => iden,
          shen => shen
        );

clk <= not clk after 10 ns;
reset <='1' after 25 ns, '0' after 65 ns;
datready <= not datready after 115 ns;
tick <= not tick after 15 ns;
count <= count + 1 after 75 ns;

END;
