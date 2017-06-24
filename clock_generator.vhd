----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:47:19 01/27/2014 
-- Design Name: 
-- Module Name:    clock_generator - Behavioral 
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clock_generator is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           h1 : out  STD_LOGIC;
           h2 : out  STD_LOGIC;
           h3 : out  STD_LOGIC;
           h4 : out  STD_LOGIC);
end clock_generator;

architecture Behavioral of clock_generator is
type type_etat is (etat0,etat1,etat2,etat3);
signal etat,etat_futur : type_etat;
signal clk_sig : std_logic;

begin
	
	--process 1 : diviseur de freq
	process(clk,reset)
	variable cpt: integer range 0 to 127;
	begin
		if reset ='1' then
		cpt := 0;
		clk_sig <='0';
		elsif rising_edge(clk) then
			cpt := cpt +1;
				if cpt =32 then
					cpt :=0;
					clk_sig<= not clk_sig;
				end if;
		end if;
	end process;
	
	
	--process 2 : machine detat
	process(clk_sig,reset)
	begin
		if reset ='1' then
		etat <=etat0;
		elsif rising_edge(clk_sig) then
		etat<=etat_futur;
		end if;
	end process;
	
	--process 3 : determination etat futur
	process (etat)
	begin
		case etat is
		when etat0 => etat_futur <= etat1;
		when etat1 => etat_futur <= etat2;
		when etat2 => etat_futur <= etat3;
		when etat3 => etat_futur <= etat0;
		end case;
	end process;
	
	--process 4: determination des sorties
	process(etat)
	begin
		case etat is
		when etat0 => h1 <='1';
						  h2 <='0';
						  h3 <='0';
						  h4 <='1';
						  
		when etat1 => h1 <='1';
						  h2 <='1';
						  h3 <='0';
						  h4 <='0';
		
		when etat2 => h1 <='0';
						  h2 <='1';
						  h3 <='1';
						  h4 <='0';
						  
		when etat3 => h1 <='0';
						  h2 <='0';
						  h3 <='1';
						  h4 <='1';
		end case;
	end process;
end Behavioral;
