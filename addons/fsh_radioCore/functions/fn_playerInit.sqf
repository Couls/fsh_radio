if (isDedicated) exitWith {};
#include "..\macros.hpp"
if (fshR_debug) then {
	'debug_console' callExtension ('C'); 
	conWhiteTime('Player init');
};

fshR_playerLoop = false;
fsh_audioName = '';
fsh_audioTitle = '';
fsh_audioArtist = '';
fsh_audioPos = -1;
fsh_audioTime = '';
fsh_audioEnd = '';
fsh_audioType = 0;
fsh_station = '';
fsh_sliderVal = -1;
fsh_sliderTimer = -1;
fsh_list_station = '';
fsh_list_track = '';

fshR_hud_hide = compileFinal "
	if (!_hud_showing) exitWith {};
	'radio_hud' cutText ['', 'PLAIN'];
	_hud_showing = false;
";

fshR_hud_show =  compileFinal "
	if (_hud_showing) exitWith {};
	'radio_hud' cutRsc ['fsh_radio_hud','PLAIN', 1, true];
	_hud_showing = true;
";



[] spawn {
	waitUntil {!isNull player};
	// Add an eventHandler
	ace_hearing_disableVolumeUpdate = true;
	0.1 fadeMusic 1.0;
	//player addEventHandler ["GetInMan", {
	//	_nul = [player] spawn fshR_fnc_playerLoop;
	//}];
	active = false;
	last = scriptNull;
	last_vehicle = objNull;
	
	closest_vehicle = objNull;
	_debug_uids = ['76561198006932022','_SP_PLAYER_'];
	if ((getPlayerUID player) in _debug_uids) then {fshR_debug = true;};
		//Stops double time in SP
		
	while {true} do {	
		scopeName "mainloop";
		
		
		// debug stuff
		//hint format ["volume: %1", musicVolume];
		
		
		_closest_vehicles = player nearEntities ["AllVehicles", AUDIO_DISTANCE];
		if (count _closest_vehicles > 0) then {
			last = [player] spawn fshR_fnc_playerLoop;
		};
		/*
		if (!isNull last && (player distance last_vehicle < 50)) then {
			// still alive
			closest_vehicle = objNull;
			_closest_vehicles = player nearEntities ["AllVehicles", 50];
			_dist = player distance last_vehicle;
			{
				if (_x getVariable ['fshR_vehInit', 0] == 2 && _dist > (player distance _x)) then {
					// other radio is playing, but closer, we check all so no break
					closest_vehicle = _x;
					closest_vehicle_playing = 2;
				};
			} forEach _closest_vehicles;
			if (!isNull closest_vehicle) then {
				terminate last;
				//cleanup
				fsh_vehicleRadioData = [0,"",-1];
				fsh_radio_action = false;
				player setVariable ['fshR_connected', false, false];
				if (fsh_audioName != "") then {playMusic ["", 0];fsh_audioName = "";fsh_audioPos=0;};
				fshR_playerLoop = false;
				//
				last = [player] spawn fshR_fnc_playerLoop;
				last_vehicle = closest_vehicle;
			};
			// else no need to do anything
		} else {
			// either no last or dist > 50
			if (!isNull last) then {
				terminate last;
				//cleanup
				fsh_vehicleRadioData = [0,"",-1];
				fsh_radio_action = false;
				player setVariable ['fshR_connected', false, false];
				if (fsh_audioName != "") then {playMusic ["", 0];fsh_audioName = "";fsh_audioPos=0;};
				fshR_playerLoop = false;
				//
				last_vehicle = objNull;
				active = false;
			};
			scopeName "checkloop";
			closest_vehicle = objNull;
			_closest_vehicles = player nearEntities ["AllVehicles", 50];
			{
				if (_x getVariable ['fshR_vehInit', 0] == 2) then {
					closest_vehicle = _x;
					closest_vehicle_playing = 2;
					breakTo "checkloop";
				};
			} forEach _closest_vehicles;
			if (!isNull closest_vehicle && !active) then {
				last = [player] spawn fshR_fnc_playerLoop;
				last_vehicle = closest_vehicle;
				active = true;
			};
		};
		*/
		
		
		/*
		_closest_vehicles = _unit nearEntities ["AllVehicles", 50];
		closest_vehicle_playing = (_closest_vehicles select 0) getVariable ['fshR_vehInit', 0];
		closest_vehicle = _closest_vehicles select 0;
		scopeName "main";
		{
			if (_x getVariable ['fshR_vehInit', 0] == 2) then {
				closest_vehicle = _x;
				closest_vehicle_playing = 2;
				breakTo "main";
			};
		} forEach _closest_vehicles;
		_closest_vehicles = player nearEntities ["AllVehicles", 50];
		if (count _closest_vehicles > 0) then {
			_closest_vehicle_playing = (_closest_vehicles select 0) getVariable ['fshR_vehInit', 0];
			if (_closest_vehicle_playing == 2 && !active) then {
				last = [player] spawn fshR_fnc_playerLoop;
				active = true;
			}
		};
		
		if (isNull last) then {
			active = false;
		};
		*/
		if (!isServer) then {
			fsh_global_time = fsh_global_time + 1;
		};
		uiSleep 1;
		
	};
	
	
	
};