----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/18/2021 12:54:20 PM
-- Design Name: 
-- Module Name: testbench - Behavioral
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

entity testbench is
port(clk:in std_logic;       
 filter:in std_logic_vector(1 downto 0);
sel :in std_logic_vector (2 downto 0);
output: out STD_LOGIC_VECTOR (data_width + coeff_width-1 downto 0));
end testbench;

architecture Behavioral of testbench is



component fir_filter is
    Port ( clk : in STD_LOGIC;
        sel :in std_logic_vector (2 downto 0);
           data : in STD_LOGIC_VECTOR (data_width-1 downto 0);
           result : out STD_LOGIC_VECTOR (data_width + coeff_width-1 downto 0));
end component;

component lowpass is
    Port ( clk : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR (data_width-1 downto 0);
           result : out STD_LOGIC_VECTOR (data_width + coeff_width-1 downto 0));
end component;

component highpass is
    Port ( clk : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR (data_width-1 downto 0);
           result : out STD_LOGIC_VECTOR (data_width + coeff_width-1 downto 0));
end component;

component avg_filter is
    Port ( clk : in STD_LOGIC;
           data : in STD_LOGIC_VECTOR (data_width-1 downto 0);
           result : out STD_LOGIC_VECTOR (data_width + coeff_width-1 downto 0));
end component;
---------------------------------------------
signal data : std_logic_vector(data_width-1 downto 0):=(others=>'0');
signal result : std_logic_vector(data_width + coeff_width-1 downto 0);
signal result2 : std_logic_vector(data_width + coeff_width-1 downto 0);
signal result3 : std_logic_vector(data_width + coeff_width-1 downto 0);
signal result4 : std_logic_vector(data_width + coeff_width-1 downto 0);

signal output_ready     :      std_logic:='0';
--------------------------------------------
 file my_input : TEXT open READ_MODE is "input.txt";  
 file my_output : TEXT open WRITE_MODE is "output.txt"; 
------------------------------------------------

begin
------------------------------------
fir:fir_filter port map (clk,sel,data,result);
lp:lowpass port map (clk,data,result2);
hp:highpass port map (clk,data,result3);
avg:avg_filter port map (clk,data,result4);
----------------------------------
           process(clk)  
           variable my_input_line : LINE;  
           variable input1: integer;  
           variable my_output_line : LINE;  
   
           begin  

                if rising_edge(clk) then                      
                     readline(my_input, my_input_line);  
                     read(my_input_line,input1);  
                     data <= std_logic_vector(to_signed(input1,8));  
                     output_ready <= '1';  
                end if;  
                     if falling_edge(clk) then  
                          write(my_output_line, to_integer(signed(result)));  
                          writeline(my_output,my_output_line);  
                    end if;
                    
                    
                     case filter is
            when "00"=>output<=result;
            when "01"=>output<=result2;
            when "10"=>output<=result3;    
            when "11"=>output<=result4;
            when others=>output<=result;
            end case;     
           end process;       
           
    
end Behavioral;
