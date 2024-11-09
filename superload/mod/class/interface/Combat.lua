local _M = loadPrevious(...)
--- Gets damage based on material level
function _M:combatMLMagicDamage(tl, base, max)
	-- Compute at "max"
	local mod = max / ((base + 100) * ((math.sqrt(5) - 1) * 0.8 + 1))
	-- Compute real
	return self:rescaleDamage((base + (self:combatSpellpower())) * ((math.sqrt(tl) - 1) * 0.8 + 1) * mod)
end

return _M