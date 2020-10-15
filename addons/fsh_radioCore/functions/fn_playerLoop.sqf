if (isDedicated || fshR_playerLoop) exitWith {}; //Server does not see the need for such trifles
#include "..\macros.hpp"
#define LONG_SLEEP 4
if (!canSuspend) exitWith {_this spawn fshR_fnc_playerLoop};
fshR_playerLoop = true;
_unit = player;


_fshR_action = -1;

if (!FSH_ACE) then {
	fsh_radio_action = false;
	_fshR_action = _unit addAction [
		"Vehicle Radio", 
		fshR_fnc_consoleOpen, 
		[], 1.5, false, true, 
		'Headlights', 
		'fsh_radio_action'
	];
};

_station_name = '';
_radio_var = '';
_data = [];
_sleepTIme = 1;
_hud_showing = false;
_vehicle = vehicle _unit;
closest_vehicle_playing = 0;
closest_vehicle = objNull;
last_vehicle = objNull;

if (_unit != _vehicle) then {
		last_vehicle = _vehicle;
	} else {
		closest_vehicle = objNull;
		closest_vehicle_playing = -1;
		_closest_vehicles = _unit nearEntities ["AllVehicles", AUDIO_DISTANCE];
		_dist = _unit distance last_vehicle;
		{
			if (_x getVariable ['fshR_vehInit', 0] == 2 && _dist > (_unit distance _x)) then {
				// other radio is playing, but closer, we check all so no break
				//hint format ["switching audio from %1 to %2", position last_vehicle, position _x];
				closest_vehicle = _x;
				closest_vehicle_playing = 2;
				last_vehicle = _x;
				
			};
		} forEach _closest_vehicles;
		if (isNull closest_vehicle) then {
			closest_vehicle = last_vehicle;
			closest_vehicle_playing = last_vehicle getVariable ['fshR_vehInit', 0];
			//hint format ["keeping audio of %1", position closest_vehicle ];
		};
	};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
while {_unit != _vehicle || (_unit == _vehicle && closest_vehicle_playing == 2)} do {
	//WE ARE IN A VEHICLE
	
	if  (_unit == _vehicle && closest_vehicle_playing == 2) then {
		//CLOSEST VEHICLE IS RUNNING FSHR!
		_unit setVariable ['fshR_connected', true, false];
		//Now check what we are playing against what we should be playing
		
		_vehicle_data = closest_vehicle getVariable ["fsh_vehicleRadio", [0, '', 0]];
		_veh_audioPos = _vehicle_data select 2;
		_veh_audioName = _vehicle_data select 1;
		_veh_audioType = _vehicle_data select 0;
		
						
		//Check to see if we are listening to radio, and if so change our data accordingly
		if (_veh_audioType == 2) then {
			_station_name = _veh_audioName;
			_time = call fsh_getTime;
			_radio_var = format ['fshR_%1', _station_name];
			_data = missionNamespace getVariable [_radio_var,['',0]];
			//_str = format['Time %1: %2', _time, _data]; conWhite(_str);
			_veh_audioName = _data select 0;
			_veh_audioPos = floor (_time - (_data select 1));
		} else {
			_radio_var = '';
			_data = [];
		};
		
		//_str = format ['%1: Song %2 (%3/%4) %5]', fsh_vehicleRadioData, _veh_audioName, _veh_audioPos, _veh_audioName call fsh_getTrackDuration, _radio_var];conGreen(_str);
		
		if (_veh_audioPos >= 0) then {
			if (fsh_audioName != _veh_audioName) then {
				//Not even on the right song you mug
				playMusic [_veh_audioName, _veh_audioPos];
				fsh_audioName = _veh_audioName;
				fsh_audioPos = _veh_audioPos;
			} else {
				if (fsh_audioName != "") then {
					_whack = abs (fsh_audioPos - _veh_audioPos);
					if (_whack > 1) then {
						//We are out of whack, play the music from where it should be
						playMusic [_veh_audioName, _veh_audioPos];
						fsh_audioPos = _veh_audioPos;
					};
				};
			};
			INC(fsh_audioPos);
		} else {
			playMusic ['', 0];
			fsh_audioName = _veh_audioName;
			fsh_audioPos = _veh_audioPos;
		};
		// audio distance
		
		_dist = _unit distance closest_vehicle;
		
		// dist is 0 - AUDIO_DISTANCE
		// 0.5 to 0
		_newvol = (1 - (_dist / AUDIO_DISTANCE));
		if (abs(_newvol - musicVolume) > 0.05) then {		
			if (_newvol < 0) then {
				0.01 fadeMusic 0;
			} else {
				0.01 fadeMusic _newvol;
			};
		};
		//hint format ["distance to car: %1 with vol %2", _dist, musicVolume];
		fsh_audioType = _veh_audioType;
		fsh_station = _station_name;
		_sleepTIme = 1;
	
	
	} else {
		if (_unit != _vehicle) then {
			_veh_rStatus = _vehicle getVariable ['fshR_vehInit', 0];
			if (_veh_rStatus != 1) then {fsh_radio_action = true;};
			if (_veh_rStatus == 2) then {
				//THIS VEHICLE IS RUNNING FSHR!
				0.1 fadeMusic 1.0;
				_unit setVariable ['fshR_connected', true, false];
				//Now check what we are playing against what we should be playing
				_veh_audioPos = fsh_vehicleRadioData select 2;
				_veh_audioName = fsh_vehicleRadioData select 1;
				_veh_audioType = fsh_vehicleRadioData select 0;
				
				//Check to see if we are listening to radio, and if so change our data accordingly
				if (_veh_audioType == 2) then {
					_station_name = _veh_audioName;
					_time = call fsh_getTime;
					_radio_var = format ['fshR_%1', _station_name];
					_data = missionNamespace getVariable [_radio_var,['',0]];
					//_str = format['Time %1: %2', _time, _data]; conWhite(_str);
					_veh_audioName = _data select 0;
					_veh_audioPos = floor (_time - (_data select 1));
				} else {
					_radio_var = '';
					_data = [];
				};
				
				//_str = format ['%1: Song %2 (%3/%4) %5]', fsh_vehicleRadioData, _veh_audioName, _veh_audioPos, _veh_audioName call fsh_getTrackDuration, _radio_var];conGreen(_str);
				
				if (_veh_audioPos >= 0) then {
					if (fsh_audioName != _veh_audioName) then {
						//Not even on the right song you mug
						playMusic [_veh_audioName, _veh_audioPos];
						fsh_audioName = _veh_audioName;
						fsh_audioPos = _veh_audioPos;
					} else {
						if (fsh_audioName != "") then {
							_whack = abs (fsh_audioPos - _veh_audioPos);
							if (_whack > 1) then {
								//We are out of whack, play the music from where it should be
								playMusic [_veh_audioName, _veh_audioPos];
								fsh_audioPos = _veh_audioPos;
							};
						};
					};
					INC(fsh_audioPos);
				} else {
					playMusic ['', 0];
					fsh_audioName = _veh_audioName;
					fsh_audioPos = _veh_audioPos;
				};
				
				fsh_audioType = _veh_audioType;
				fsh_station = _station_name;
				_sleepTIme = 1;
			} else {
				playMusic ['', 0];
				
				_sleepTIme = LONG_SLEEP;
			};
		};
		
	};
	
	//Sleep
	uiSleep _sleepTIme;
	_vehicle = vehicle _unit;
	
	scopeName "coreloop";
	
	if (_unit != _vehicle) then {
		last_vehicle = _vehicle;
	} else {
		closest_vehicle = objNull;
		closest_vehicle_playing = -1;
		_closest_vehicles = _unit nearEntities ["AllVehicles", AUDIO_DISTANCE];
		_dist = _unit distance last_vehicle;
		{
			if (_x getVariable ['fshR_vehInit', 0] == 2 && _dist > (_unit distance _x)) then {
				// other radio is playing, but closer, we check all so no break
				//hint format ["switching audio from %1 to %2", position last_vehicle, position _x];
				closest_vehicle = _x;
				closest_vehicle_playing = 2;
				last_vehicle = _x;
				
			};
		} forEach _closest_vehicles;
		if (isNull closest_vehicle) then {
			closest_vehicle = last_vehicle;
			closest_vehicle_playing = last_vehicle getVariable ['fshR_vehInit', 0];
			//hint format ["keeping audio of %1", position closest_vehicle ];
		};
	};
};
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//We are not in a vehicle


fsh_vehicleRadioData = [0,"",-1];
fsh_radio_action = false;
_unit setVariable ['fshR_connected', false, false];
_unit removeAction _fshR_action;
if (fsh_audioName != "") then {playMusic ["", 0];fsh_audioName = "";fsh_audioPos=0;};

call fshR_hud_hide;
0.1 fadeMusic 0.0;
playMusic ['', 0];
fshR_playerLoop = false;