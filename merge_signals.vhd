----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:22:54 01/27/2014 
-- Design Name: 
-- Module Name:    merge_signals - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity merge_signals is
    Port ( datarw : in  STD_LOGIC;
           dataadr : in  STD_LOGIC_VECTOR (6 downto 0);
           dataout : out  STD_LOGIC_VECTOR (7 downto 0));
end merge_signals;

architecture Behavioral of merge_signals is

begin
	dataout <= dataadr&datarw;
end Behavioral;

