--[[
Script to add new store category(s) in the mod view

Author:		Ifko[nator]
Date:		25.10.2016
Version:	1.5

History:	V 1.0 @ 16.11.2015 - intial release
			V 1.1 @ 09.12.2015 - bug fix for wrong placement of the new category in the mod view
			V 1.5 @ 25.10.2016 - add support for the new categories from FS 17
]]

local count = 0;
local modDesc = loadXMLFile("modDesc", g_currentModDirectory .. "modDesc.xml");

while true do
	local baseString = string.format("modDesc.storeItems.newCategories.newCategory(%d)", count);
	
	if not hasXMLProperty(modDesc, baseString) then
		break;
	end;
	
	local name = getXMLString(modDesc, baseString .. "#name");
	local previousCategory = getXMLString(modDesc, baseString .. "#previousCategory");
	local imageFilename = getXMLString(modDesc, baseString .. "#imageFilename");
	local image = Utils.getFilename(imageFilename, g_currentModDirectory);
	
	local modFilename, isMod, ModDirectoryIndex = Utils.removeModDirectory(g_currentModDirectory);
	
	if (name and image) ~= (nil and "") then
		if isMod then 
			local storeUtil = StoreItemsUtil.storeCategories;
			local storeItem = storeUtil.animals.orderId;
			
			if previousCategory ~= (nil and "") then
				if previousCategory == "sales" 							then storeItem = storeUtil.sales.orderId;
					elseif previousCategory == "tractors" 				then storeItem = storeUtil.tractors.orderId;
					--elseif previousCategory == "frontloaders" 			then storeItem = storeUtil.frontloaders.orderId;
					elseif previousCategory == "frontLoaders" 			then storeItem = storeUtil.frontLoaders.orderId;
					elseif previousCategory == "trucks" 				then storeItem = storeUtil.trucks.orderId;
					elseif previousCategory == "harvesters" 			then storeItem = storeUtil.harvesters.orderId;
					elseif previousCategory == "cutters" 				then storeItem = storeUtil.cutters.orderId;
					elseif previousCategory == "forageHarvesters" 		then storeItem = storeUtil.forageHarvesters.orderId;
					elseif previousCategory == "forageHarvesterCutters" then storeItem = storeUtil.forageHarvesterCutters.orderId;
					elseif previousCategory == "cutterTrailers" 		then storeItem = storeUtil.cutterTrailers.orderId;
					elseif previousCategory == "potatoHarvesting" 		then storeItem = storeUtil.potatoHarvesting.orderId;
					elseif previousCategory == "beetHarvesting" 		then storeItem = storeUtil.beetHarvesting.orderId;
					elseif previousCategory == "tippers" 				then storeItem = storeUtil.tippers.orderId;
					elseif previousCategory == "dollys" 				then storeItem = storeUtil.dollys.orderId;
					elseif previousCategory == "plows" 					then storeItem = storeUtil.plows.orderId;
					elseif previousCategory == "cultivators" 			then storeItem = storeUtil.cultivators.orderId;
					elseif previousCategory == "sowingMachines" 		then storeItem = storeUtil.sowingMachines.orderId;
					elseif previousCategory == "fertilizerSpreaders"	then storeItem = storeUtil.fertilizerSpreaders.orderId;
					elseif previousCategory == "sprayers" 				then storeItem = storeUtil.sprayers.orderId;
					elseif previousCategory == "manureSpreaders" 		then storeItem = storeUtil.manureSpreaders.orderId;
					elseif previousCategory == "slurryTanks" 			then storeItem = storeUtil.slurryTanks.orderId;
					elseif previousCategory == "weeders" 				then storeItem = storeUtil.weeders.orderId;
					elseif previousCategory == "mowers" 				then storeItem = storeUtil.mowers.orderId;
					elseif previousCategory == "tedders" 				then storeItem = storeUtil.tedders.orderId;
					elseif previousCategory == "windrowers" 			then storeItem = storeUtil.windrowers.orderId;
					elseif previousCategory == "loaderWagons" 			then storeItem = storeUtil.loaderWagons.orderId;
					elseif previousCategory == "baling" 				then storeItem = storeUtil.baling.orderId;
					elseif previousCategory == "feeding" 				then storeItem = storeUtil.feeding.orderId;
					elseif previousCategory == "augerWagons" 			then storeItem = storeUtil.augerWagons.orderId;
					elseif previousCategory == "weights" 				then storeItem = storeUtil.weights.orderId;
					elseif previousCategory == "wood" 					then storeItem = storeUtil.wood.orderId;
					elseif previousCategory == "chainsaws" 				then storeItem = storeUtil.chainsaws.orderId;
					elseif previousCategory == "cars" 					then storeItem = storeUtil.cars.orderId;
					elseif previousCategory == "wheelLoaders" 			then storeItem = storeUtil.wheelLoaders.orderId;
					elseif previousCategory == "teleLoaders" 			then storeItem = storeUtil.teleLoaders.orderId;
					elseif previousCategory == "skidSteers" 			then storeItem = storeUtil.skidSteers.orderId;
					elseif previousCategory == "leveler" 				then storeItem = storeUtil.leveler.orderId;
					elseif previousCategory == "lowloaders" 			then storeItem = storeUtil.lowloaders.orderId;
					elseif previousCategory == "misc" 					then storeItem = storeUtil.misc.orderId;
					elseif previousCategory == "belts" 					then storeItem = storeUtil.belts.orderId;
					elseif previousCategory == "placeables" 			then storeItem = storeUtil.placeables.orderId;
					elseif previousCategory == "pallets" 				then storeItem = storeUtil.pallets.orderId;
					elseif previousCategory == "animals" 				then storeItem = storeUtil.animals.orderId;
				else
					print("[INFO (addStoreCategory.lua)]: The previous category '" .. previousCategory .. "' is not an standard category! Adding the category '" .. name .. "' from the Mod '" .. g_currentModName .. "' as last!");
				end;
			else
				print("[INFO (addStoreCategory.lua)]: Missing the previous category name! Adding the category '" .. name .. "' from the Mod '" .. g_currentModName .. "' as last!");
			end;
		
			if storeUtil[name] == nil then
				if g_i18n:hasText(name) then	
					storeUtil[name] = {
						orderId = storeItem + 0.1,
						name = name,
						title = g_i18n:getText(name),
						image = image
					};
				else
					print("[Error (addStoreCategory.lua)]: Missing the l10n entry for '" .. name .. "'! Stop adding the category(" .. count .. ") from the Mod '" .. g_currentModName .. "' now!");
				end;
			end;
		end;
	else
		if name == (nil or "") then
			print("[Error (addStoreCategory.lua)]: Missing the category name! Stop adding the category(" .. count .. ") from the Mod '" .. g_currentModName .. "' now!");
		else
			print("[Error (addStoreCategory.lua)]: Missing the image  for the category '" .. name .. "'! Stop adding the category(" .. count .. ") from the Mod '" .. g_currentModName .. "' now!");
		end;
	end;

	count = count + 1;
end;