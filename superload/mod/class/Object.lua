local _M = loadPrevious(...)

function _M:craftWeaponAddOnEffect(effect, kind, def)
	if not self.combat then return end
	if not self.combat[effect] then self.combat[effect] = {} end
	if self.combat[effect].fct then self.combat[effect] = {self.combat[effect]} end
	def._kind = kind
	table.insert(self.combat[effect], def)
end

function _M:craftWeaponRemoveOnEffect(effect, kind)
	if not self.combat then return end
	if not self.combat[effect] then return end
	if self.combat[effect].fct then return end
	for i, def in ipairs(self.combat[effect]) do
		if def._kind == kind then
			table.remove(self.combat[effect], i)
			break
		end
	end
end

return _M