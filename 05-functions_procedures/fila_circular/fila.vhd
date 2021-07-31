-------------------------------------------------------
--! @file
--! @brief Fila circular usando funções e procedimentos.
--
--! @author: Suzi Yousif
--!          Renan Augusto Starke 
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package fila is
	type dados_array is array (natural range <>) of unsigned (7 downto 0);
	
	type fila_t is record
		cabeca:unsigned(3 downto 0);
		cauda:unsigned(3 downto 0);
		tamanho:unsigned(4 downto 0);
		--tamanho_max:integer;
		dados: dados_array(15 downto 0);
	end record;
	
	procedure cria_fila(signal fila: inout fila_t);
		--constant tamanho: in integer);
		
	procedure dequeue(signal fila: inout fila_t;
		signal dado: out unsigned (7 downto 0));
		
	procedure enqueue (constant x: unsigned(7 downto 0);
		signal fila: inout fila_t);
		
	function fila_vazia(fila : fila_t) return boolean;	
	
end package fila;

package body fila is

	--procedure cria_fila(signal fila: inout fila_t;
	--	constant tamanho: in integer)  is
	procedure cria_fila(signal fila: inout fila_t) is		
	begin
		fila.cabeca <= "0000";
		fila.cauda <= "0000";
		fila.tamanho <= "00000";
		--fila.tamanho_max <= tamanho;
		fila.dados <= (others => (others => '0'));
	end procedure cria_fila;
	
	
	procedure enqueue (constant x: unsigned(7 downto 0);
		  signal fila: inout fila_t) is
	begin
		-- fila.cauda <= fila.cauda + 1;
		if fila.tamanho <= 15 then
			fila.dados(to_integer(fila.cauda)) <= x;
			fila.tamanho <= fila.tamanho + 1;
			fila.cauda <= fila.cauda + 1;
		end if;
	end enqueue;

	procedure dequeue(signal fila: inout fila_t;
		signal dado: out unsigned (7 downto 0))  is
	begin
		
		if fila.tamanho > 0 then
			dado <= fila.dados((to_integer(fila.cabeca)));
			fila.cabeca <= fila.cabeca + 1;
			fila.tamanho <= fila.tamanho - 1;
		end if;
	end procedure dequeue;


	function fila_vazia(fila : fila_t) return boolean is	
	begin
		if fila.tamanho = 0 then
			return true;
		else 
			return false;
		end if;
	end function fila_vazia;
	
	
end package body fila;
