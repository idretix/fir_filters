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

entity avg_filter is
    Port ( clk : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR (data_width-1 downto 0);
           result : out STD_LOGIC_VECTOR (data_width + coeff_width-1 downto 0));
end avg_filter;

architecture Behavioral of avg_filter is

signal data2: std_logic_vector(data_width-1 downto 0):= (others=>'0');

signal data_pipeline:data_array:= (others=>(others=>'0'));
signal products:products_array:= (others=>(others=>'0'));
signal t:std_logic_vector (31 downto 0);
begin

process (clk)
    
    variable sum:signed((data_width + coeff_width -1) downto 0); --suma produselor
    
   variable my_output_line : LINE;  

begin
    if (clk'event and clk='1') then
            
        data_pipeline<= signed(data) & data_pipeline(0 to taps-2);--shiftam noile date in pipeline
        sum:= (others =>'0');--initializam suma cu 0
        for i in 0 to 9 loop
            sum:=sum+data_pipeline(i);
        end loop;
        t<=std_logic_vector(sum * 1/10);
        result<=t(15 downto 0);
    end if;
    
end process;


end Behavioral;
