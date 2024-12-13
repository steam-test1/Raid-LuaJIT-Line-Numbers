WeaponInventoryTweakData = WeaponInventoryTweakData or class()

-- Lines 3-56
function WeaponInventoryTweakData:init()
	self.weapon_primaries_index = {
		{
			weapon_id = "thompson",
			slot = 1
		},
		{
			weapon_id = "mp38",
			slot = 2
		},
		{
			weapon_id = "sterling",
			slot = 3
		},
		{
			weapon_id = "garand",
			slot = 4
		},
		{
			weapon_id = "mp44",
			slot = 5
		},
		{
			weapon_id = "m1918",
			slot = 6
		},
		{
			weapon_id = "mg42",
			slot = 7
		},
		{
			weapon_id = "m1903",
			slot = 8
		},
		{
			weapon_id = "mosin",
			slot = 9
		},
		{
			weapon_id = "m1912",
			slot = 10
		},
		{
			weapon_id = "sten",
			slot = 11
		},
		{
			weapon_id = "carbine",
			slot = 12
		},
		{
			weapon_id = "garand_golden",
			slot = 13
		}
	}
	self.weapon_secondaries_index = {
		{
			weapon_id = "m1911",
			slot = 1
		},
		{
			weapon_id = "c96",
			slot = 2
		},
		{
			weapon_id = "webley",
			slot = 3
		}
	}
	self.weapon_grenades_index = {
		{
			default = true,
			slot = 1,
			weapon_id = "m24"
		}
	}
	self.weapon_melee_index = {
		{
			default = true,
			slot = 1,
			redeemed_xp = 0,
			droppable = false,
			weapon_id = "m3_knife"
		},
		{
			droppable = true,
			slot = 2,
			weapon_id = "robbins_dudley_trench_push_dagger",
			redeemed_xp = 20
		},
		{
			droppable = true,
			slot = 3,
			weapon_id = "german_brass_knuckles",
			redeemed_xp = 30
		},
		{
			droppable = true,
			slot = 4,
			weapon_id = "lockwood_brothers_push_dagger",
			redeemed_xp = 40
		},
		{
			droppable = true,
			slot = 5,
			weapon_id = "bc41_knuckle_knife",
			redeemed_xp = 50
		},
		{
			droppable = false,
			slot = 6,
			weapon_id = "km_dagger",
			redeemed_xp = 60
		},
		{
			droppable = false,
			slot = 7,
			weapon_id = "marching_mace",
			redeemed_xp = 70
		}
	}
end
