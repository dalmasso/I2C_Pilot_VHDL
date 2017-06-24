----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:33:39 01/27/2014 
-- Design Name: 
-- Module Name:    fsm_master - Behavioral 
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

entity fsm_master is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           rw : in  STD_LOGIC;
           en_i2c : in  STD_LOGIC;
           sda : in  STD_LOGIC;
           bit_count : in  STD_LOGIC_VECTOR (3 downto 0);
           en_count : out  STD_LOGIC;
           sr_count : out  STD_LOGIC;
           ld_addr : out  STD_LOGIC;
           ld_data_wr : out  STD_LOGIC;
           en_scl : out  STD_LOGIC;
           sel_datain : out  STD_LOGIC;
			  busy : out STD_LOGIC;
           sel_sda : out  STD_LOGIC_VECTOR (1 downto 0);
           sel_shiftreg : out  STD_LOGIC_VECTOR (1 downto 0);
           en_ack_master : out  STD_LOGIC;
           en_dec_sda : out  STD_LOGIC);
end fsm_master;

architecture Behavioral of fsm_master is
type etatsys is (ready,start,write_addr1,write_addr2,slave_ack1,write_data1,write_data2,slave_ack2,read_data,master_ack1,master_ack2,stop);
signal etat,etat_futur: etatsys;

begin

	--registre d'état
	process(clk,reset)
	begin
		if reset='1' then
		etat <= ready;
		elsif rising_edge(clk) then
		etat <= etat_futur;
		end if;
	end process;

	--determination etat futur
	process(rw,en_i2c,sda,bit_count,etat)
	begin
		
		case etat is
		when ready => if en_i2c ='0' then etat_futur <= ready;
						  else etat_futur <= start;
						  end if;
		when start => etat_futur <= write_addr1;
		when write_addr1 => etat_futur <= write_addr2;
		when write_addr2 => if bit_count ="1000" then etat_futur <= slave_ack1;
								  else etat_futur <= write_addr2;
								  end if;
		when slave_ack1 => if sda='0' and rw='0' then etat_futur <= write_data1;
								 elsif sda='0' and rw='1' then etat_futur <= read_data;
								 elsif sda='1' then etat_futur <= stop;
								 end if;
		when write_data1 => etat_futur <= write_data2;
		when write_data2 => if bit_count="1000" then etat_futur <= slave_ack2;
								  else etat_futur <= write_data2;
								  end if;
		when slave_ack2 => if sda='1' or en_i2c='0' then etat_futur <=stop;
								 elsif sda='0' and en_i2c='1' and rw='1' then etat_futur <=start;
								 elsif sda='0' and en_i2c='1' and rw='0' then etat_futur <=write_data1;
								 else etat_futur <= slave_ack2;
								 end if;
		when read_data => if bit_count="1000" and en_i2c='0' then etat_futur <=master_ack2;
							   elsif bit_count="1000" and en_i2c='1' then etat_futur <=master_ack1;
								else etat_futur <=read_data;
								end if;
		when master_ack1 => if rw='1' then etat_futur <= read_data;
								  else etat_futur <= start;
								  end if;
		when master_ack2 => etat_futur <=stop;
		when stop => etat_futur <= ready;
		end case;
	end process;
	
	--determination des sorties
	process(etat)
	begin
		case etat is
		when ready => --compteur de bit remis à zero
						  en_count <='0';
						  sr_count <='1';
						  --sda en etat z
						  en_dec_sda <='0';
						  sel_sda	 <="11";		
						  --chargement addr dans register lié a addr
						  ld_addr <='1';						  
						  --chargement data_wr dans register lié a data_wr
						  ld_data_wr <='1';						  
						  --mode mémoire de shift register
						  sel_shiftreg <="00";						  
						  --scl en etat z
						  en_scl <='0';						  
						  --selection addr vers shift register
						  sel_datain <='0';						  
						  --le périphérique n'est pas occupé
						  busy <= '0';						  
						  --pas utilisé ici
						  en_ack_master <='0';						  
						  
		when start => --compteur de bit pas encore utilisé
						  en_count <='0';
						  sr_count <='0';						  
						  --sda recopie h4
						  en_dec_sda <='1';
						  sel_sda	 <="00";						  
						  --pas utilise
						  ld_addr <='1';						  
						  --pas utilise
						  ld_data_wr <='1';						  
						  --mode mémoire de shift register
						  sel_shiftreg <="00";						  
						  --scl recopie h1
						  en_scl <='0';						  
						  --selection addr vers shift register
						  sel_datain <='0';						  
						  --le périphérique est occupé
						  busy <= '1';						  
						  --pas utilisé ici
						  en_ack_master <='0';
						  
		when write_addr1 => --compteur de bit utilise
								  en_count <='1';
								  sr_count <='0';								  
								  --sda recopie dataout de shift register
								  en_dec_sda <='1';
								  sel_sda	 <="10";								  
								  --pas utilise
								  ld_addr <='0';								  
								  --pas utilise
								  ld_data_wr <='0';								  
								  --mode chargement de shift register
								  sel_shiftreg <="11";								  
								  --scl recopie h1
								  en_scl <='1';								  
								  --pas utilise
								  sel_datain <='0';								  
								  --le périphérique est occupé
								  busy <= '1';
								  --pas utilisé ici
								  en_ack_master <='0';
	  when write_addr2 => --compteur de bit utilise
								  en_count <='1';
								  sr_count <='0';								  
								  --sda recopie dataout de shift register
								  en_dec_sda <='1';
								  sel_sda	 <="10";								  
								  --pas utilise
								  ld_addr <='0';								  
								  --pas utilise
								  ld_data_wr <='0';							  
								  --mode decalage droite de shift register
								  sel_shiftreg <="01";								  
								  --scl recopie h1
								  en_scl <='1';								  
								  --pas utilise
								  sel_datain <='0';								  
								  --le périphérique est occupé
								  busy <= '1';								  
								  --pas utilisé ici
								  en_ack_master <='0';
		when slave_ack1 => --compteur de bit remis a zero
								  en_count <='0';
								  sr_count <='1';								  
								  --sda etat z (lit provenant slave)
								  en_dec_sda <='0';
								  sel_sda	 <="00";								  
								  --pas utilise
								  ld_addr <='0';								  
								  --pas utilise
								  ld_data_wr <='0';								  
								  --mode chargement de shift register
								  --prevoit ecrire data_wr sur meme bus. si on sera mode lecture (valeur 'rw')
								  sel_shiftreg <="11";								  
								  --scl recopie h1
								  en_scl <='1';								  
								  --selection data_wr
								  sel_datain <='1';								  
								  --le périphérique est occupé
								  busy <= '1';								  
								  --pas utilisé ici
								  en_ack_master <='0';		  
		when write_data1 => --compteur de bit utilise
								  en_count <='1';
								  sr_count <='0';								  
								  --sda recopie dataout de shift register
								  en_dec_sda <='1';
								  sel_sda	 <="10";								  
								  --pas utilise
								  ld_addr <='0';								  
								  --pas utilise
								  ld_data_wr <='0';								  
								  --mode chargement de shift register
								  sel_shiftreg <="11";								  
								  --scl recopie h1
								  en_scl <='1';								  
								  --pas utilise
								  sel_datain <='1';								  
								  --le périphérique est occupé
								  busy <= '1';								  
								  --pas utilisé ici
								  en_ack_master <='0';

		when write_data2 => --compteur de bit utilise
								  en_count <='1';
								  sr_count <='0';								  
								  --sda recopie dataout de shift register
								  en_dec_sda <='1';
								  sel_sda	 <="10";								  
								  --pas utilise
								  ld_addr <='0';
								  --pas utilise
								  ld_data_wr <='0';								  
								  --mode decalage droite de shift register
								  sel_shiftreg <="01";								  
								  --scl recopie h1
								  en_scl <='1';								  
								  --pas utilise
								  sel_datain <='1';								  
								  --le périphérique est occupé
								  busy <= '1';								  
								  --pas utilisé ici
								  en_ack_master <='0';

		when slave_ack2 => --compteur de bit remis a zero
								  en_count <='0';
								  sr_count <='1';								  
								  --sda en z
								  en_dec_sda <='0';
								  sel_sda	 <="00";								  
								  --on charge nouvelle adresse
								  ld_addr <='1';								  
								  --on charge nouvelle donnee
								  ld_data_wr <='1';								  
								  --mode chargement de data_wr de shift register
								  --prevoit ecrire data_wr sur meme bus si on sera mode lecture (valeur 'rw')
								  sel_shiftreg <="11";								  
								  --scl recopie h1
								  en_scl <='1';								  
								  --selection data_wr
								  sel_datain <='1';								  
								  --le périphérique a termine ecriture une donnee
								  busy <= '0';								  
								  --pas utilisé ici
								  en_ack_master <='0';

		when read_data => --compteur de bit utilise
								  en_count <='1';
								  sr_count <='0';								  
								  --sda etat z
								  en_dec_sda <='0';
								  sel_sda	 <="00";								  
								  --pas utilise
								  ld_addr <='0';								  
								  --pas utilise
								  ld_data_wr <='0';								  
								  --mode decalage droite de shift register
								  sel_shiftreg <="01";								  
								  --scl recopie h1
								  en_scl <='1';
								  --pas utilise
								  sel_datain <='1';								  
								  --le périphérique est occupé
								  busy <= '1';								  
								  --pas utilisé ici
								  en_ack_master <='0';							  
		when master_ack1 => --compteur de bit remis a zero
								  en_count <='0';
								  sr_count <='1';
								  --sda mis a 0 par le master
								  en_dec_sda <='1';
								  sel_sda	 <="11";								  
								  --mise a jour adresse cyble
								  ld_addr <='1';								  
								  --mise a jour possible de donne a ecrire
								  ld_data_wr <='1';								  
								  --mode lecture de shift register
								  sel_shiftreg <="00";								  
								  --scl recopie h1
								  en_scl <='1';								  
								  --pas utilise
								  sel_datain <='1';								  
								  --le périphérique terminé lecture d'une donne
								  busy <= '0';								  
								  --ack mis a 0 par master apres lecture dune donne
								  en_ack_master <='0';
								  
		when master_ack2 => --compteur de bit remis a zero
								  en_count <='0';
								  sr_count <='1';								  
								  --sda mis a 1 par master
								  en_dec_sda <='1';
								  sel_sda	 <="11";								  
								  --mise a jour adresse cible
								  ld_addr <='1';								  
								  --mise a jour possible donnee a ecrire
								  ld_data_wr <='1';								  
								  --mode lecture de shift register
								  sel_shiftreg <="00";								  
								  --scl recopie h1
								  en_scl <='1';								  
								  --pas utilise
								  sel_datain <='1';								  
								  --le périphérique termine lecture dune donnee
								  busy <= '0';								  
								  --ack mis a 1 par master apres lecture dune donne
								  en_ack_master <='1';
		when stop => 		  --compteur no utilise
								  en_count <='0';
								  sr_count <='0';								  
								  --sda recopie h2(stop)
								  en_dec_sda <='1';
								  sel_sda	 <="01";								  
								  --mise a jour adresse cible
								  ld_addr <='1';								  
								  --mise a jour possible donnee a ecrire
								  ld_data_wr <='1';								  
								  --mode lecture de shift register
								  sel_shiftreg <="00";								  
								  --scl recopie h1
								  en_scl <='1';								  
								  --pas utilise
								  sel_datain <='1';								  
								  --le périphérique a termine lecture dune donnee
								  busy <= '0';								  
								  --pas utilisé ici
								  en_ack_master <='0';
		end case;
	end process;		
end Behavioral;