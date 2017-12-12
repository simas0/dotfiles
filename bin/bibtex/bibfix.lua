re = require"re"
inspect = require"inspect"

p = [=[
ha <- bibfile
bibfile         <- { entry+ } .* !.
entry           <- ws type ws '{' ws key ',' ws ({| field |}  ws ',' ws)*-- {| field |}? ws '}' ','? ws
type            <- '@' identifier
specifier       <- ([A-Za-z0-9:()] / '-')+
string          <- ([A-Za-z0-9:,()-;] / %s / %nl)+
latex_string    <- balanced
balanced        <- string / ( string? '{' string? ([^{}] / balanced)* string? '}' string? )
field           <- {:field_name: name :} ws '=' ws value
name            <- specifier
value           <- ws ( '"' ws {:value: docpiece :} '"' ws ) / ('{' ws {:value: latex_string :} '}' ws)
docpiece        <- {| cmd |} / multiline
envblock        <- openbrace key closebrace
cmd	        <- cmdslash {:command: identifier :}
cmdblock        <- openbrace {:nodes: {| docpiece* |} :} closebrace
key	        <- ws {:key: identifier :}
multiline       <- (nl? text)+
text	        <- (!cmd !closebrace !%nl [_%w%p%s])+
identifier      <- [_%w:]+
cmdslash        <- ws '\'
assign	        <- ws '='
sep	        <- ws ','
openbrace       <- ws '{'
closebrace      <- ws '}'
opensq	        <- ws '['
closesq	        <- ws ']'
nl              <- %nl
ws              <- (nl / %s)*

]=]

f = io.open("all.bib", "rb")
content = f:read("*all")

c = [=[
@article{Sh:15,
author = {Shelah, Saharon},
ams-subject = {(02H05)},
journal = {Journal of Symbolic Logic},
review = {MR 47:4787},
pages = {107--113},
title = {{Uniqueness and characterization of prime models over sets for
 totally transcendental first-order theories}},
volume = {37},
year = {1972},
}

]=]

print(inspect(re.match(content,p)))



--grammar = lpeg.P{
--   "bibfile";
--   bibfile = {| entry |} .* !.
--   entry  = ws * type * '{' * ws * key * ',' * ws * ({| field |} * ',' * ws)^0 * { field } * '}' * ws,
--   key	  = string * ws,
--   type	  = '@' * string * ws,
--   string = [A-Za-z0-9]+,
--   ws	  = [%s%nl]*,
--   field  = {:field_name: name :} * ws * '=' * ws * {:field_value: value :} * ws,
--   name	  = string,
--   value  = [^,%nl]*,
--}



--for k, p in pairs(grammar) do
--  local enter = lpeg.Cmt(lpeg.P(true), function(s, p, ...)
--  print("ENTER", k) return p end);
--  local leave = lpeg.Cmt(lpeg.P(true), function(s, p, ...)
--  print("LEAVE", k) return p end) * (lpeg.P("k") - lpeg.P "k");
--  grammar[k] = lpeg.Cmt(enter * p + leave, function(s, p, ...)
--  print("---", k, "---") print(p, s:sub(1, p-1)) return p end)
--end
--
--print(grammar.match(content))
