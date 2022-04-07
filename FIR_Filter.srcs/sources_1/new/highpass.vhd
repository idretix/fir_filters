----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/07/2021 11:16:01 PM
-- Design Name: 
-- Module Name: fir_filter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use ieee.numeric_std.all;
use work.types.all;
use std.textio.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity highpass is
    Port ( clk : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR (data_width-1 downto 0);
           result : out STD_LOGIC_VECTOR (data_width + coeff_width-1 downto 0));
end highpass;

architecture Behavioral of highpass is

signal data2: std_logic_vector(data_width-1 downto 0):= (others=>'0');

signal data_pipeline:data_array:= (others=>(others=>'0'));




begin

process (clk)
    
begin
            
            if (signed(data)>10) then
            result<=x"000a";
            else
            result<=x"00" & data;
            end if;    
end process;

end Behavioral;
