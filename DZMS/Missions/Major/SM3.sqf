/*
	Medical Supply Camp by lazyink (Full credit for original code to TheSzerdi & TAW_Tonic)
	Updated to New Mission Format by Vampire
*/

private ["_coords","_crate","_crate2","_vehicle","_base1","_base2"];

//DZMSFindPos loops BIS_fnc_findSafePos until it gets a valid result
_coords = call DZMSFindPos;

[nil,nil,rTitleText,"Bandits have set up a medical re-supply camp! Check your map for the location!", "PLAIN",10] call RE;

//DZMSAddMajMarker is a simple script that adds a marker to the location
[_coords] call DZMSAddMajMarker;

//Create the scenery
_base1 = createVehicle ["land_fortified_nest_big",[(_coords select 0) - 20, (_coords select 1) - 10,-0.2],[], 0, "CAN_COLLIDE"];
_base2 = createVehicle ["Land_Fort_Watchtower",[(_coords select 0) - 10, (_coords select 1) + 10,-0.2],[], 0, "CAN_COLLIDE"];
[_base1] call DZMSProtectObj;
[_base2] call DZMSProtectObj;

//Create the vehicles
_vehicle = createVehicle ["HMMWV_DZ",[(_coords select 0) + 25, (_coords select 1) - 5,0],[], 0, "CAN_COLLIDE"];
[_vehicle] call DZMSSetupVehicle;

//Create the loot
_crate = createVehicle ["USVehicleBox",[(_coords select 0) + 5, (_coords select 1),0],[], 0, "CAN_COLLIDE"];
[_crate,"medical"] call DZMSBoxSetup;

_crate2 = createVehicle ["USLaunchersBox",[(_coords select 0) + 12, _coords select 1,0],[], 0, "CAN_COLLIDE"];
[_crate2,"weapons"] call DZMSBoxSetup;

//DZMSAISpawn spawns AI to the mission.
//Usage: [_coords, count, skillLevel]
[_coords,3,1] call DZMSAISpawn;
sleep 5;
[_coords,3,1] call DZMSAISpawn;
sleep 5;
[_coords,3,1] call DZMSAISpawn;

//Wait until the player is within 30meters
waitUntil{{isPlayer _x && _x distance _baserunover < 10  } count playableunits > 0}; 

//Let everyone know the mission is over
[nil,nil,rTitleText,"Survivors have taken control of the camp and medical supplies.", "PLAIN",6] call RE;
diag_log format["[DZMS]: Major SM3 Medical Camp Mission has Ended."];
deleteMarker "DZMSMajMarker";

//Let the timer know the mission is over
DZMSMajDone = true;