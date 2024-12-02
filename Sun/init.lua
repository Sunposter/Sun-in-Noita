dofile("data/scripts/lib/utilities.lua")
dofile( "data/scripts/perks/perk.lua" )

function OnPlayerSpawned( player_entity )

	if tonumber(StatsGetValue("playtime")) < 1 then
		-- Random starting loadouts compatibility fix, basically just setting several file paths back to default
		if ModIsEnabled("starting_loadouts") then
			ComponentSetValue( EntityGetFirstComponent( player_entity, "SpriteComponent" ), "image_file", "data/enemies_gfx/player.xml" )
			ComponentSetValue( EntityGetFirstComponent( player_entity, "DamageModelComponent" ), "ragdoll_filenames_file", "data/ragdolls/player/filenames.txt" )
			ComponentSetValue( EntityGetFirstComponent( player_arm, "SpriteComponent" ), "image_file", "data/enemies_gfx/player_arm.xml" )
			-- For the arm simply setting the path isn't enough, we need to kill it and load it again
			local plyrChildEnt = EntityGetAllChildren( player_entity )
			if ( plyrChildEnt ~= nil ) then
				for i,chldEntity in ipairs( plyrChildEnt ) do
					local childName = EntityGetName( chldEntity)
					if ( childName == "arm_r" ) then
						EntityKill( chldEntity )
						arm_entity = EntityLoad( "mods/marisa/files/entities/player_arm.xml")
						EntityAddChild( player_entity, arm_entity )
						break
					end
				end
			end
		end
		
		--Tiny fix so the bottom of the sprite doesn't clip by one pixel
		ComponentSetValue( EntityGetFirstComponent( player_entity, "SpriteComponent" ), "offset_y", "15" )

		local cape = EntityGetWithName("cape")
		local cape_verlet = EntityGetFirstComponentIncludingDisabled(cape, "VerletPhysicsComponent")
		ComponentSetValue2(cape_verlet, "cloth_color", 0xFF1F1F1F)
		ComponentSetValue2(cape_verlet, "cloth_color_edge", 0xFF000000)
		
		end
end

		