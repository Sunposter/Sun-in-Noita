dofile("data/scripts/lib/utilities.lua")

local player = get_players()[1]
local player_vel = EntityGetFirstComponent(player, "VelocityComponent")
local player_vx, player_vy = ComponentGetValue2(player_vel, "mVelocity")

local invComp = EntityGetFirstComponent(player, "Inventory2Component")
local e_hand = ComponentGetValue2(invComp, "mActiveItem", eid)

local e_arm = EntityGetWithName("arm_r")

if e_arm ~= nil then
	local arm_x, arm_y = EntityGetTransform(e_arm)
	EntitySetTransform(e_arm, arm_x + player_vx, arm_y + player_vy)
end

local inventory = EntityGetWithName("inventory_quick")
if inventory ~= nil then
	local items = EntityGetAllChildren( inventory )
	if items ~= nil then
		local hand_x, hand_y = EntityGetTransform(e_hand)
		EntitySetTransform(e_hand, hand_x + player_vx, hand_y + player_vy)
	end
end
