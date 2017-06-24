-- Vhdl test bench created from schematic E:\i2c\i2c_master_usart.sch - Wed Mar 26 13:48:50 2014
--
-- Notes: 
-- 1) This testbench template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the unit under test.
-- Xilinx recommends that these types always be used for the top-level
-- I/O of a design in order to guarantee that the testbench will bind
-- correctly to the timing (post-route) simulation model.
-- 2) To use this template as your testbench, change the filename to any
-- name of your choice with the extension .vhd, and use the "Source->Add"
-- menu in Project Navigator to import the testbench. Then
-- edit the user defined section below, adding code to generate the 
-- stimulus for your design.
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;
ENTITY i2c_master_usart_i2c_master_usart_sch_tb IS
END i2c_master_usart_i2c_master_usart_sch_tb;
ARCHITECTURE behavioral OF i2c_master_usart_i2c_master_usart_sch_tb IS 

   COMPONENT i2c_master_usart
   PORT( tx	:	OUT	STD_LOGIC; 
          sda	:	INOUT	STD_LOGIC; 
          scl	:	INOUT	STD_LOGIC; 
          rw	:	IN	STD_LOGIC; 
          reset	:	IN	STD_LOGIC; 
          clk	:	IN	STD_LOGIC);
   END COMPONENT;

   SIGNAL tx	:	STD_LOGIC;
   SIGNAL sda	:	STD_LOGIC:='Z';
   SIGNAL scl	:	STD_LOGIC;
   SIGNAL rw	:	STD_LOGIC:='1';
   SIGNAL reset	:	STD_LOGIC;
   SIGNAL clk	:	STD_LOGIC:='0';
	
		-- Signaux pour testbench
	type tab is array (0 to 1) of std_logic_vector(7 downto 0);
	--signal addr_slave : std_logic_vector(6 downto 0):="0000000";
	--signal read_write_slave : std_logic; 
	--signal data_read_from_slave : std_logic_vector(7 downto 0):="00000000";
	signal data_read_from_slave : tab;

BEGIN

   UUT: i2c_master_usart PORT MAP(
		tx => tx, 
		sda => sda, 
		scl => scl, 
		rw => rw, 
		reset => reset, 
		clk => clk
   );

------------------------------------------------------
-- Horloge et reset
------------------------------------------------------
-- Horloge H du master est de 100MHz (10 ns): horloge de la carte Nexys3
-- Horloge SCL de la ligne I2C est fixé ici à 400kHz (2.5 us)
clk <= not clk after 5 ns;
reset <= '1', '0' after 152 ns;

data_read_from_slave(0) <= "01010101";
data_read_from_slave(1) <= "00110011";

-- Processus de gestion des signaux en écriture vers slave
-- ou en lecture depuis slave
process
variable i : natural;
variable j : natural;
variable addr_slave : std_logic_vector(6 downto 0);
variable read_write_slave : std_logic;
begin

	-- Attente du START
	wait until (falling_edge(SDA) and SCL = 'Z');
	report "start ok";
	-- Boucle pour récupérer les 7 premiers bits de l'adresse
	for i in 6 downto 0 loop
		wait until (rising_edge(SCL));
		-- Signal affectée utilisée dans ce type de processus !
		-- affectation d'une valeur à un signal ne prend effet que lorsque 
		-- le processus se remet en attente.
		addr_slave(i) := SDA;
		report "Adresse modifie";
	end loop;
	wait until (rising_edge(SCL));
	read_write_slave := SDA;
	-- le prochain front descendant de SCL sera utilisée pour mettre SDA = '0' (ACQ)
	-- si addr_sig = "1010101", sinon SDA = 'Z' (slave non concerné !)
	wait until (falling_edge(SCL));
	if (addr_slave /= "1001011") then
		SDA <= 'Z';
		report "Slave non concerné";
	else
		-- Mise à '0' de ACK
		SDA <= '0';
		
		-- Mode écriture dans SLAVE
		if (read_write_slave = '0') then
			report "!!!!! Mode écriture : pas testé ici !!!!!";

		--Mode lecture depuis SLAVE
		else 
			report "debut lecture depuis le SLAVE des données";
			j := 0;
			etiq2 : loop
				for i in 7 downto 0 loop
					wait until (falling_edge(SCL));
					SDA <= data_read_from_slave(j)(i);
					wait for 1 us;
					exit etiq2 when (data_read_from_slave(j)(i) /= SDA);
				end loop;
				-- ACQ est mis à 'Z' par le SLAVE dans l'attente d'un ACQ de la part du MASTER
				wait until (falling_edge(SCL));
				SDA <= 'Z';
				-- ligne SDA testé pour savoir si ACQ = '0' par le Master 
				-- si ACQ = '1' on attend un stop
				-- sinon on reboucle pour envoi d'une nouvelle donnée
				wait until (rising_edge(SCL));
				exit etiq2 when (SDA = '1');
				j := 1;
				report "fin lecture data depuis SLAVE";
			end loop etiq2;
			report "sortie du mode lecture depuis slave";
			-- ligne SDA libéré pour envoi prochaine donnée
			wait until (falling_edge(SCL));
			SDA <= 'Z';
		end if;
	end if;
end process;

END;
