----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:38:48 03/17/2014 
-- Design Name: 
-- Module Name:    fsm_usart_tx - Behavioral 
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fsm_usart_tx is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           datready : in  STD_LOGIC;
           tick : in  STD_LOGIC;
           count : in  STD_LOGIC_VECTOR (3 downto 0);
           txbusy : out  STD_LOGIC;
           iden : out  STD_LOGIC;
           shen : out  STD_LOGIC);
end fsm_usart_tx;

architecture Behavioral of fsm_usart_tx is

type etattype is (idle, synchro_load, load, synchro, send);
signal etat,etatfutur : etattype;

begin

		-- registre d'etat
		process (clk,reset)
		begin
			if reset='1' then
				etat <= idle;
			elsif falling_edge (clk) then
				etat <= etatfutur;
			end if;
		end process;
		
		
		-- determination etat futur
		process (etat, datready, tick, count)
		begin
			case etat is
			
			when idle => if datready='1' then etatfutur <= synchro_load;
					  else etatfutur <= idle;
					  end if;
					  
			when synchro_load => if tick ='1' then etatfutur <= load;
								 else etatfutur <= synchro_load;
								 end if;
								 
			when load => etatfutur <= synchro;
			
			when synchro => if tick ='1' then etatfutur <= send;
								 else etatfutur <= synchro;
								 end if;
								 
			when send => if count="1001" then etatfutur <= idle;
							 else etatfutur <= synchro;
							 end if;
			end case;
		end process;
		
		
		-- determination sortie
		process(etat)
		begin
			case etat is
			when idle => shen <='0';
							 iden <='0';
							 txbusy <='0';
					  
			when synchro_load => shen <='0';
							 iden <='0';
							 txbusy <='1';
								 
			when load => shen <= '0';
							 iden <='1';
							 txbusy <='1';
			
			when synchro => shen <='0';
							 iden <='0';
							 txbusy <='1';
								 
			when send => shen <='1';
							 iden <='0';
							 txbusy <='1';
			end case;
		end process;


end Behavioral;

