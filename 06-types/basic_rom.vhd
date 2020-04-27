-------------------------------------------------------------------
-- name        : basic_rom.vhd
-- author      : Renan Augusto Starke
-- version     : 0.1
-- copyright   : Instituto Federal de Santa Catarina
-- description : Read-only memory using array
-------------------------------------------------------------------

-- bibliotecas e clásulas

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity basic_rom is
  port(endereco : in  unsigned(3 downto 0); -- valores de 0 a 15
       ce       : in  std_logic;            -- habitita memoria
       saida    : out unsigned(7 downto 0));-- saida de dados da memoria
end basic_rom ;

architecture teste of basic_rom is
  type     arranjo_memoria is array (natural range <>) of unsigned(7 downto 0);
  
  constant dados : arranjo_memoria(0 to 15) :=
  ("00000011","10011111","00100101","00001101","10011000", -- valores posicoes 0,1,2,3,4
   "01001001","01000001","00011111","00011001","00001001", -- valores posicoes 5,6,7,8,9
   "01001001","01000001","00010111","00000001","01001001","01000110"); -- posicoes restantes
   
begin
  saida <= dados(to_integer(endereco)) when ce='1' else (others=>'Z');
end teste;