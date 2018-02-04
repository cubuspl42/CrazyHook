patches = {
	% for patch in patches:
	{
		-- ${patch.name}
		virtual_address = ${hex(patch.virtual_address)},
		data = {
			% for byte in patch.data:
				${hex(byte)}, \
			% endfor
		}
	},
	% endfor
}
