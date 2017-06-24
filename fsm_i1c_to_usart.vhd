----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:30:32 03/24/2014 
-- Design Name: 
-- Module Name:    fsm_i1c_to_usart - Behavioral 
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

entity fsm_i2c_to_usart is
    Port ( clk 				   : in  STD_LOGIC;
           reset 					: in  STD_LOGIC;
           busy_i2c 				: in  STD_LOGIC;
           busy_usart 			: in  STD_LOGIC;
           T_1sec				 	: in  STD_LOGIC;
           data_to_write 		: out  STD_LOGIC_VECTOR (7 downto 0);
           adress_slave 		: out  STD_LOGIC_VECTOR (6 downto 0);
           en_i2c 				: out  STD_LOGIC;
           sel_temp_out_i2c   : out  STD_LOGIC;
           sel_temp_in_usart 	: out  STD_LOGIC;
           load_msb_temp 		: out  STD_LOGIC;
           load_lsb_temp 		: out  STD_LOGIC;
           data_ready_usart 	: out  STD_LOGIC);
end fsm_i2c_to_usart;

architecture Behavioral of fsm_i2c_to_usart is
TYPE state_type IS (start, wait_busy_high1, wait_busy_low1, tempo1, tempo2,
						  read_MSB_Temp, wait_busy_high2, wait_busy_low2, tempo3,
						  tempo4, read_LSB_Temp, send_LSB_Temp, wait_TXbusy_low1,
						  send_MSB_Temp, wait_TXbusy_low2, wait_1sec);
signal state, next_state : state_type;
begin


	state_register : process(clk, reset)
	begin
		if reset = '1' then
			state <= start;
		elsif rising_edge(clk) then
			state <= next_state;
		end if;
	end process;
	
	compute_next_state : process(state, busy_i2c, busy_usart, T_1sec)
	begin
		case state is
			-- Démarrage de l'I2C : en_i2c = '1'
			when start => next_state <= wait_busy_high1;
			
			-- Attente d'un niveau '1' de busy_i2c
			when wait_busy_high1 => if (busy_i2c = '0') then
											next_state <= wait_busy_high1;
											else
											next_state <= wait_busy_low1;
											end if;
				
			-- Attente d'un niveau '0' de busy_i2c
			-- (l'octet MSB de la Temp est disponible)
			when wait_busy_low1 => if (busy_i2c = '1') then
										  next_state <= wait_busy_low1;
										  else
										  next_state <= tempo1;
										  end if;
				
			-- temporisation pour être sûr d'avoir la donnée en
			-- sortie du registre
			when tempo1 => next_state <= tempo2;
			
			when tempo2 => next_state <= read_MSB_Temp;
			
			when read_MSB_Temp => next_state <= wait_busy_high2;
			
			-- Attente d'un niveau '1' de busy_i2c
			when wait_busy_high2 => if (busy_i2c = '0') then
											next_state <= wait_busy_high2;
											else
											next_state <= wait_busy_low2;
											end if;
			
			-- Attente d'un niveau '0' de busy_i2c
			-- (l'octet LSB de la Temp est disponible)			
			when wait_busy_low2 => if (busy_i2c = '1') then
										  next_state <= wait_busy_low2;
										  else
										  next_state <= tempo3;
										  end if;
			
			when tempo3 => next_state <= tempo4;
			
			when tempo4 => next_state <= read_LSB_Temp;
				
			when read_LSB_Temp => next_state <= send_LSB_Temp;
				
			-- FIN DE l'I2C

			-- envoi du LSB de Temp par Usart
			when send_LSB_Temp => next_state <= wait_TXbusy_low1;
				
			-- Attente d'un niveau '0' de busy_usart
			-- (l'octet LSB de la Temp a été envoyée)
			when wait_TXbusy_low1 => if (busy_usart = '1') then
											 next_state <= wait_TXbusy_low1;
											 else
											 next_state <= send_MSB_Temp;
											 end if;
				
			-- envoi du MSB de Temp par Usart
			when send_MSB_Temp => next_state <= wait_TXbusy_low2;
				
			-- Attente d'un niveau '0' de busy_usart
			-- (l'octet MSB de la Temp a été envoyée)
			when wait_TXbusy_low2 => if (busy_usart = '1') then
											 next_state <= wait_TXbusy_low2;
											 else
											 next_state <= wait_1sec;
											 end if;
		
			-- Attente d'un niveau '1' sur T_1sec
			-- Attente d'une seconde...
			when wait_1sec => if (T_1sec = '0') then
								   next_state <= wait_1sec;
								   else
								   next_state <= start;
									end if;
		end case;
	end process;
	
	outputs_fixed : process(state)
	begin
		case state is
			when start => data_to_write <= "00000000";	
							  adress_slave <= "1001011";	
								-- I2C est lancé
								en_i2c <= '1';		
								-- Choix octet MSB(1)/LSB(0) de la donnée température
								sel_Temp_out_i2c <= '0';
								sel_Temp_in_usart	<= '0';
								-- Donnée pas encore lue : donc à inhiber
								load_MSB_Temp	<= '0';	
								load_LSB_Temp	<= '0';	
								-- Usart pas encore utilisé	
								data_ready_usart <= '0';
				
			when wait_busy_high1 => data_to_write <= "00000000";	
											adress_slave <= "1001011";	
											-- I2C est lancé
											en_i2c <= '1';		
											-- Choix octet MSB(1)/LSB(0) de la donnée température
											sel_Temp_out_i2c <= '1';
											sel_Temp_in_usart	<= '0';
											-- Donnée pas encore lue : donc à inhiber
											load_MSB_Temp	<= '1';
											load_LSB_Temp	<= '0';		
											-- Usart pas encore utilisé	
											data_ready_usart <= '0';
				
			when wait_busy_low1 =>  data_to_write <= "00000000";	
											adress_slave <= "1001011";	
											-- I2C est lancé
											en_i2c <= '0';
											-- Choix octet MSB(1)/LSB(0) de la donnée température
											sel_Temp_out_i2c <= '1';
											sel_Temp_in_usart	<= '0';
											-- Donnée pas encore lue : donc à inhiber
											load_MSB_Temp	<= '1';		
											load_LSB_Temp	<= '0';	
											-- Usart pas encore utilisé	
											data_ready_usart <= '0';
			
			when tempo1 => 			data_to_write <= "00000000";	
											adress_slave <= "1001011";	
											-- I2C est lancé
											en_i2c <= '1';	
											-- Choix octet MSB(1)/LSB(0) de la donnée température
											sel_Temp_out_i2c <= '1';
											sel_Temp_in_usart	<= '0';
											-- Donnée pas encore lue : donc à inhiber
											load_MSB_Temp	<= '1';
											load_LSB_Temp	<=	'0';
											-- Usart pas encore utilisé	
											data_ready_usart <= '0';
			
			when tempo2 => 			data_to_write <= "11111111";	
											adress_slave <= "1001011";	
											-- I2C est lancé
											en_i2c <= '1';		
											-- Choix octet MSB(1)/LSB(0) de la donnée température
											sel_Temp_out_i2c <= '1';
											sel_Temp_in_usart	<= '0';
											-- Donnée pas encore lue : donc à inhiber
											load_MSB_Temp	<=	'1';
											load_LSB_Temp	<= '0';	
											-- Usart pas encore utilisé	
											data_ready_usart <= '0';
				
			when read_MSB_Temp =>   data_to_write <= "11111111";	
											adress_slave <= "1001011";	
											-- I2C est lancé
											en_i2c <= '1';		
											-- Choix octet MSB(1)/LSB(0) de la donnée température
											sel_Temp_out_i2c <= '0';
											sel_Temp_in_usart	<= '1';
											-- Donnée pas encore lue : donc à inhiber
											load_MSB_Temp	<= '0';	
											load_LSB_Temp	<= '0';	
											-- Usart pas encore utilisé	
											data_ready_usart <= '0';
				
			when wait_busy_high2 => data_to_write <= "11111111";	
											adress_slave <= "1001011";	
											-- I2C est lancé
											en_i2c <='1';			
											-- Choix octet MSB(1)/LSB(0) de la donnée température
											sel_Temp_out_i2c <= '0';
											sel_Temp_in_usart	<= '0';
											-- Donnée pas encore lue : donc à inhiber
											load_MSB_Temp	<= '0';	
											load_LSB_Temp	<= '1';	
											-- Usart pas encore utilisé	
											data_ready_usart <= '0';
				
			when wait_busy_low2 =>  data_to_write <= "11111111";	
											adress_slave <= "1001011";	
											-- I2C sera arrêté
											en_i2c <='0';			
											-- Choix octet MSB(1)/LSB(0) de la donnée température
											sel_Temp_out_i2c <= '0';
											sel_Temp_in_usart	<= '0';
											-- Donnée pas encore lue : donc à inhiber
											load_MSB_Temp	<= '0';
											load_LSB_Temp	<=	'1';	
											-- Usart pas encore utilisé	
											data_ready_usart <= '0';
			
			when tempo3 => 			data_to_write <= "11111111";	
											adress_slave <= "1001011";	
											-- I2C sera arrêté
											en_i2c <= '0';			
											-- Choix octet MSB(1)/LSB(0) de la donnée température
											sel_Temp_out_i2c <= '0';
											sel_Temp_in_usart	<= '0';
											-- Donnée pas encore lue : donc à inhiber
											load_MSB_Temp	<=	'0';	
											load_LSB_Temp	<= '1';	
											-- Usart pas encore utilisé	
											data_ready_usart <= '0';
				
			when tempo4 =>  			data_to_write <= "11111111";	
											adress_slave <= "1001011";	
											-- I2C sera arrêté
											en_i2c <= '0';		
											-- Choix octet MSB(1)/LSB(0) de la donnée température
											sel_Temp_out_i2c <= '0';
											sel_Temp_in_usart	<= '0';
											-- Donnée pas encore lue : donc à inhiber
											load_MSB_Temp	<= '0';	
											load_LSB_Temp	<= '1';		
											-- Usart pas encore utilisé	
											data_ready_usart <= '0';
				
			when read_LSB_Temp => 	data_to_write <= "11111111";	
											adress_slave <= "1001011";	
											-- I2C sera arrêté
											en_i2c <= '0';			
											-- Choix octet MSB(1)/LSB(0) de la donnée température
											sel_Temp_out_i2c <= '0';
											sel_Temp_in_usart	<= '0';
											-- Donnée pas encore lue :
											load_MSB_Temp	<= '0';	
											load_LSB_Temp	<= '0';	
											-- Usart pas encore utilisé	
											data_ready_usart <='0';
				
			when send_LSB_Temp => 	data_to_write <= "11111111";	
											adress_slave <= "0110100";	
											-- I2C sera arrêté
											en_i2c <='0';		
											-- Choix octet MSB(1)/LSB(0) de la donnée température
											sel_Temp_out_i2c <= '0';
											sel_Temp_in_usart	<= '0'; 
											-- Donnée pas encore lue : donc à inhiber
											load_MSB_Temp	<= '0';		
											load_LSB_Temp	<= '0';	
											-- Usart lancé	
											data_ready_usart <= '1';
				

			when wait_TXbusy_low1 => data_to_write <= "11111111";	
											 adress_slave <= "0110100";	
											 -- I2C sera arrêté
											 en_i2c <=	'0';	
											 -- Choix octet MSB(1)/LSB(0) de la donnée température
											 sel_Temp_out_i2c <= '0';
											 sel_Temp_in_usart	<= '0';
											 -- Donnée pas encore lue : donc à inhiber
											 load_MSB_Temp	<= '0';	
											 load_LSB_Temp	<= '0';	
											 -- Usart arrêté	
											 data_ready_usart <='0';--'1';
				
			when send_MSB_Temp =>  	 data_to_write <= "11111111";	
											 adress_slave <= "0110100";	
											 -- I2C sera arrêté
											 en_i2c <= '0';	
											 -- Choix octet MSB(1)/LSB(0) de la donnée température
											 sel_Temp_out_i2c <= '0';
											 sel_Temp_in_usart	<= '1';
											 -- Donnée pas encore lue : donc à inhiber
											 load_MSB_Temp	<= '0';
											 load_LSB_Temp	<=	'0';
											 -- Usart lancé	
											 data_ready_usart <= '1';
				
			when wait_TXbusy_low2 => data_to_write <= "11111111";	
											 adress_slave <= "0110100";	
											 -- I2C sera arrêté
											 en_i2c <= '0';			
											 -- Choix octet MSB(1)/LSB(0) de la donnée température
											 sel_Temp_out_i2c <= '0';
											 sel_Temp_in_usart	<= '1';
											 -- Donnée pas encore lue : donc à inhiber
											 load_MSB_Temp	<= '0';	
											 load_LSB_Temp	<= '0';	
											 -- Usart arrêté	
											 data_ready_usart <= '0';--'1'; 
				
			when wait_1sec =>  		 data_to_write <= "00000000";	
											 adress_slave <= "0000000";	
											 -- I2C sera arrêté
											 en_i2c <= '0';		
											 -- Choix octet MSB(1)/LSB(0) de la donnée température
											 sel_Temp_out_i2c <= '0';
											 sel_Temp_in_usart	<= '0';
											 -- Donnée pas encore lue : donc à inhiber
											 load_MSB_Temp	<= '0';
											 load_LSB_Temp	<= '0';		
											 -- Usart arrêté	
											 data_ready_usart <= '0';
											
		end case;
	end process;
end Behavioral;

