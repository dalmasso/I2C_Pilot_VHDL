----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:14:23 03/17/2014 
-- Design Name: 
-- Module Name:    top_usart_tx - Behavioral 
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

entity top_usart_tx is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           datain : in  STD_LOGIC_VECTOR (7 downto 0);
           dataready : in  STD_LOGIC;
           txbusy : out  STD_LOGIC;
           tx : out  STD_LOGIC);
end top_usart_tx;

architecture structural of top_usart_tx is

component counter4bit_enable_seqreset
port ( clk		:in std_logic;
		 reset	:in std_logic;
		 seqreset:in std_logic;
		 enable  : in std_logic;
		 dataout : out std_logic_vector (3 downto 0));
end component;

component fsm_usart_tx
port ( clk     :in std_logic;
		 reset	:in std_logic;
		 count	:in std_logic_vector (3 downto 0);
		 datready:in std_logic;
		 tick		:in std_logic;
		 txbusy	:out std_logic;
		 iden		:out std_logic;
		 shen		:out std_logic);
end component;

component shiftleft_register10bit
port ( clk     :in std_logic;
		 reset	:in std_logic;
		 serialleftin:in std_logic;
		 loaden :in std_logic;
		 shiften:in std_logic;
		 datain :in std_logic_vector (9 downto 0);
		 dataout :out std_logic);
end component;

component tick_generator	
generic( freqboard : integer := 100000000;
			baud : integer := 9600);
port ( clk     :in std_logic;
		 reset	:in std_logic;
		 tick		:out std_logic);
end component;

signal count_sig : std_logic_vector (3 downto 0);
signal iden_sig : std_logic;
signal shen_sig : std_logic;
signal tick_sig : std_logic;

begin

u0 : fsm_usart_tx
port map ( clk 		=> clk,
			  reset		=> reset,
			  count		=> count_sig,
			  datready	=> dataready,
			  tick		=> tick_sig,
			  txbusy		=> txbusy,
			  iden		=> iden_sig,
			  shen		=> shen_sig);
			  

u1: counter4bit_enable_seqreset
port map ( clk 		=> clk,
			  reset		=> reset,
			  seqreset	=> iden_sig,
			  enable		=> shen_sig,
			  dataout	=> count_sig);
			  

u2: shiftleft_register10bit
port map ( clk 		=> clk,
			  reset		=> reset,
			  serialleftin =>'0',
			  loaden => iden_sig,
			  shiften	=> shen_sig,
			  datain(0) =>'0',
			  datain(9) =>'1',
			  datain(8 downto 1) => datain,
			  dataout => tx);
			  
			  
u3: tick_generator
port map (clk 		=> clk,
			 reset		=> reset,
			 tick	=> tick_sig);

end structural;

