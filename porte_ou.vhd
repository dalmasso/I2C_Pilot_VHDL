----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:54:02 01/28/2014 
-- Design Name: 
-- Module Name:    porte_ou - Behavioral 
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

entity porte_ou is
    Port ( sig1 : in  STD_LOGIC;
           sig2 : in  STD_LOGIC;
           sig_out : out  STD_LOGIC);
end porte_ou;

architecture Behavioral of porte_ou is

begin

sig_out <= sig1 or sig2;

end Behavioral;

