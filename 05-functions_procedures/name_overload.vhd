-------------------------------------------------------------------
-- name        : name_overload.vhd
-- author      : Renan Augusto Starke
-- version     : 0.1
-- copyright   : Instituto Federal de Santa Catarina
-- description : Local function and name overload
-------------------------------------------------------------------

-- bibliotecas e clásulas

entity name_overload is
	port (ai, bi, ci : in  integer range 0   to 15;
	     ar, br     : in  real    range 0.0 to 15.0;
	     si, ti     : out integer range 0   to 31;
	     sr         : out real    range 0.0 to 31.0);
end name_overload;

architecture teste of name_overload is
	function soma (a, b : integer) return integer is     -- 1a funcao
	begin
		return a + b;
	end soma;

	function soma (a, b, c : integer) return integer is  -- 2a funcao
	begin
		return a + b + c;
	end soma;

	function soma (x, y : real) return real is           -- 3a funcao
	begin
		return x + y + 1.0;
	end soma;
begin
	si <= soma(ai,bi);    -- ai,bi operandos tipo integer    -> 1a funcao
	ti <= soma(ai,bi,ci); -- ai,bi,ci operandos tipo integer -> 2a funcao
	sr <= soma(ar,br);    -- ar,br operandos tipo real       -> 3a funcao
end teste;