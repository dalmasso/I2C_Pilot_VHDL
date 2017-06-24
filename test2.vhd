-- Vhdl test bench created from schematic E:\i2c\i2c_global.sch - Mon Feb 10 15:40:06 2014
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
ENTITY i2c_global_i2c_global_sch_tb IS
END i2c_global_i2c_global_sch_tb;
ARCHITECTURE behavioral OF i2c_global_i2c_global_sch_tb IS 

   COMPONENT i2c_global
   PORT( busy	:	OUT	STD_LOGIC; 
          rw	:	IN	STD_LOGIC; 
          en_i2c	:	IN	STD_LOGIC; 
          addr_wr	:	IN	STD_LOGIC_VECTOR (6 DOWNTO 0); 
          clk_100MHz	:	IN	STD_LOGIC; 
          reset	:	IN	STD_LOGIC; 
          data_wr	:	IN	STD_LOGIC_VECTOR (7 DOWNTO 0); 
          data_rd	:	OUT	STD_LOGIC_VECTOR (7 DOWNTO 0); 
          scl	:	INOUT	STD_LOGIC; 
          sda	:	INOUT	STD_LOGIC);
   END COMPONENT;

   SIGNAL busy	:	STD_LOGIC;
   SIGNAL rw	:	STD_LOGIC;
   SIGNAL en_i2c	:	STD_LOGIC;
   SIGNAL addr_wr	:	STD_LOGIC_VECTOR (6 DOWNTO 0);
   SIGNAL clk_100MHz	:	STD_LOGIC:='0';
   SIGNAL reset	:	STD_LOGIC;
   SIGNAL data_wr	:	STD_LOGIC_VECTOR (7 DOWNTO 0);
   SIGNAL data_rd	:	STD_LOGIC_VECTOR (7 DOWNTO 0);
   SIGNAL scl	:	STD_LOGIC;
   SIGNAL sda	:	STD_LOGIC:='Z';
	
	
		-- signaux pour testbench
	signal addr_slave : std_logic_vector(6 downto 0) := "0000000";
	signal read_write_slave : std_logic;
	signal data_read_from_slave : std_logic_vector(7 downto 0) := "00000000";
	signal data_write_to_slave : std_logic_vector(7 downto 0) := "00000000";
	signal data_write : std_logic_vector (7 downto 0) := (others => '0');

	
	

BEGIN

   UUT: i2c_global PORT MAP(
		busy => busy, 
		rw => rw, 
		en_i2c => en_i2c, 
		addr_wr => addr_wr, 
		clk_100MHz => clk_100MHz, 
		reset => reset, 
		data_wr => data_wr, 
		data_rd => data_rd, 
		scl => scl, 
		sda => sda
   );

-----------------------------------------------------------------------
-- Horloge et reset
-----------------------------------------------------------------------
-- Horloge H du master est de 100 MHz (10 ns) : horloge de la carte Nexys3
-- Horloge SCL de la ligne I2C est fixé ici à 400kHz (2,5 us)
clk_100MHz <= not clk_100MHz after 5 ns;
reset <= '1', '0' after 152 ns;

-- Processus pour signaux de démarrage
process
begin
	-- ecriture de données
	addr_wr <= "1010101";
	data_wr <= "11001100";
	rw <= '0';
	en_I2C <= '0';
	wait for 10 us;
	en_I2C <= '1';
	wait for 20 us;
	data_wr <= "10011001";
	wait until (busy = '0');
	en_I2C <= '0';
	wait for 20 us;
	en_I2C <= '1';
	wait for 20 us;
	en_I2C <= '0';
	wait for 10 us;
	en_I2C <= '1';
	wait until (busy = '0');
	en_I2C <= '0';
	wait for 30 us;
	-- lecture de données
	en_I2C <= '1';
	rw <= '1';
	--addr_wr <= "1001001";
	data_read_from_slave <= "10001111";
	wait for 10 us;
	en_I2C <= '1';
	wait until (busy = '0');
	data_read_from_slave <= "00110101";
	wait for 5 us;
	en_I2C <= '0';
	wait;
end process;

-- Mise à jour du signal écrit au slave uniquement sur frotn descendant du busy
data_write_to_slave <= data_write when (falling_edge(busy));

-- processus de gestion des signaux en ecriture vers slave
-- ou en lecture depuis slave
process
variable i : natural;
begin

	-- attente du start
	wait until (falling_edge(SDA) and SCL = 'Z');
	report "start ok";
	-- boucle pour récupérer les 7 premiers bits de l'adresse
	for i in 6 downto 0 loop
		wait until (rising_edge(SCL));
		--signal affectée utilisée dans ce type de processus !
		-- affectation d'une valeur à un signal bne prend effet que lorsque
		-- le processus se remet en attente
		addr_slave(i) <= SDA;
		report "Adresse modifie";
	end loop;
	wait until (rising_edge(SCL));
	read_write_slave <= SDA;
	-- le prochain front descendant de SCL sera utilisée pour mettre SDA = '0' (ACQ)
	-- si addr_sig = '1010101', sinon SDA = 'Z' (slave non concerné !)
	wait until (falling_edge(SCL));
	if (addr_slave /= "1010101") then
		SDA <= 'Z';
		report "Slave non concerné";
	else
		-- mise à zéro de ACK
		SDA <= '0';
		
		-- Mode écriture dans SLAVE
		if (read_write_slave = '0') then
			-- au prochain front descendant de SCL on remet SDA = 'Z'
			wait until (falling_edge(SCL));
			SDA <= 'Z';
			report "debut écriture dans le slave des données";
			etiq1 : loop
				for i in 7 downto 0 loop
					wait until (rising_edge(SCL));
					data_write(i) <= SDA;
					-- test si STOP (ou STOP) pas envoyé (peut-être envoyé n'importe quand d'après la norme)
					-- le temps d'attente ici est fixé < à 1/2 période de SCL, mais suffisamment grand
					-- pour que SDA soit passer à ... '1' dans le cas du STOP / ou '0' dans cas du START
					wait for 1 us;
					exit etiq1 when (data_write(i) /= SDA);
				end loop;
				-- ACQ est à '0'
				wait until (falling_edge(SCL));
				SDA <= '0';
				-- ligne SDA libéré pour envoi prochaine donnée
				wait until (falling_edge(SCL));
				SDA <= 'Z';
				report "fin écriture data depuis SLAVE";
			end loop etiq1;
			
		-- Mode lecture depuis SLAVE
		else
			report "debut lecture depuis le SLAVE des données";
			etiq2 : loop
				for i in 7 downto 0 loop
					wait until (falling_edge(SCL));
					SDA <= data_read_from_slave(i);
					-- test si STOP (ou STOP) pas envoyé (peut-être envoyé n'importe quand d'après la norme)
					-- le temps d'attente ici est fixé < à 1/2 période de SCL, mais dans cas du START
						wait for 1 us;
						exit etiq2 when (data_read_from_slave(i) /= SDA);
				end loop;
				-- ACQ est mis à 'Z' par le SLAVE dans l'attente d'un ACQ de la part du MASTER
				wait until (falling_edge(SCL));
				SDA <= 'Z';
				-- ligne SDA esté pour savoir si ACQ = '0' par le master
				-- si ACQ = '1' on attend un stop
				-- sinon on reboucle pour envoi d'une nouvelle donnée
				wait until (rising_edge(SCL));
				exit etiq2 when (SDA ='1');
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
