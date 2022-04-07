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

entity fir_filter is
    Port ( clk : in STD_LOGIC;
           sel: in std_logic_vector (2 downto 0);
           data : in STD_LOGIC_VECTOR (data_width-1 downto 0);
           result : out STD_LOGIC_VECTOR (data_width + coeff_width-1 downto 0));
end fir_filter;

architecture Behavioral of fir_filter is

signal data2: std_logic_vector(data_width-1 downto 0):= (others=>'0');

signal coefficient:coefficient_array;
signal data_pipeline:data_array:= (others=>(others=>'0'));
signal products:products_array:= (others=>(others=>'0'));

file my_output : TEXT open WRITE_MODE is "output.txt"; 


constant coeff: coefficient_array := (x"f6",-- -10
                                    x"f7",-- -9
                                    x"f8",-- -8
                                    x"f9",-- -7
                                    x"fa",-- -6
                                    x"fb",-- -5
                                    x"fc",-- -4
                                    x"fd",-- -3
                                    x"fe",-- -2
                                    x"ff",-- -1
                                    x"f6",-- -10
                                    x"f7",-- -9
                                    x"f8",-- -8
                                    x"f9",-- -7
                                    x"fa",-- -6
                                    x"fb",-- -5
                                    x"fc",-- -4
                                    x"fd",-- -3
                                    x"fe",-- -2
                                    x"ff");-- -1
constant coeff2: coefficient_array := (x"00",-- 0
                                    x"01",-- 0
                                    x"02",-- 
                                    x"01",-- 1
                                    x"00",-- 0
                                    x"ff",-- -1
                                    x"fe",-- -2
                                    x"ff",-- -1
                                    
                                    x"00",-- 0
                                    
                                    x"01",-- 1
                                    x"02",-- 2
                                    x"01",-- 1
                                    x"00",-- 0
                                    x"ff",-- -1
                                    x"fe",-- -2
                                    x"ff",-- -1
                                    x"00",
                                    x"01",
                                    x"02",
                                    x"01"
                                    );-- 0
                                    
 constant coeff3: coefficient_array := (x"01",-- 0
                                    x"01",-- 0
                                    
                                    x"01",-- 
                                    
                                    x"01",-- 1
                                    x"01",-- 1
                                    x"01",-- 1
                                    x"01",-- 1
                                    x"01",-- 1
                                    
                                    x"01",-- 1
                                    
                                    x"f6",-- 1
                                    x"ff",-- 1
                                    x"01",-- 1
                                    x"01",-- 1
                                    x"01",-- 1
                                    x"01",-- 1
                                    x"01",-- 1
                                    x"01",-- 1
                                    x"01",
                                    x"01",-- 1
                                    x"01"
                                    );-- 0
begin

process (clk)
    
    variable sum:signed((data_width + coeff_width -1) downto 0); --suma produselor
    
   variable my_output_line : LINE;  

begin
    if (clk'event and clk='1') then
            
    case sel is
        when "000"=> coefficient<=coeff;
        when "001"=>coefficient<=coeff2;
        when "010"=>coefficient<=coeff3;
        when others => coefficient<=coeff;
    end case;
    
        data_pipeline<= signed(data) & data_pipeline(0 to taps-2);--shiftam noile date in pipeline
        sum:= (others =>'0');--initializam suma cu 0
        for i in 0 to taps-1 loop
            sum:=sum+products(i);
        end loop;
                  -- write(my_output_line,to_integer(signed(sum)));  
                 --  writeline(my_output,my_output_line);   
        result<=std_logic_vector(sum);
    end if;
    
end process;

--inmultiri
product_calc: for i in 0 to taps-1 generate
    products(i) <= data_pipeline(i) * signed(coefficient(i));
end generate;

end Behavioral;
