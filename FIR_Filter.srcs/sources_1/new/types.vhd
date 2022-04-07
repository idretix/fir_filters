----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/07/2021 10:38:43 PM
-- Design Name: 
-- Module Name: types - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

package types is

constant taps : integer:=20; --numarul de "taps" al filtrului
constant data_width:integer:=8; --lungimea cuvintelor de date de intrare
constant coeff_width:integer:=8; --lungimea coeficientilor

type coefficient_array is array (0 to taps-1) of signed(coeff_width-1 downto 0);
type data_array is array (0 to taps-1) of signed(data_width-1 downto 0);
type products_array is array (0 to taps-1) of signed(15 downto 0);

end package types;