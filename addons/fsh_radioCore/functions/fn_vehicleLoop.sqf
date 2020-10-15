#include "..\macros.hpp"
#define LONG_SLEEP 4
#define SHUTDOWN_TIME 30
#define DEF_SONG_LENTGH 225
scopeName "main";

if (!canSuspend) exitWith {_this spawn fshR_fnc_vehicleInit};
if (!isServer) exitWith {};	//add a forwarding function here!
_vehicle = _this select 0;
if (_vehicle getVariable ['fshR_vehInit', 0] != 0) exitWith {};

//_data = [_mode, _station, _vSong, _vSongTime];
_vrd = _vehicle getVariable ['fshR_vrd', [2, fsh_stations call bis_fnc_selectRandom, fsh_music call bis_fnc_selectRandom, 0]];
_mode = _vrd select 0;
_station = _vrd select 1;
_vSong = _vrd select 2;
_vSongTime = _vrd select 3;;
_vSongEnd = 0;

_vehicle setVariable ['fshR_tracks', fsh_music, true];
_vehicle setVariable ['fshR_vehInit', 2, true];

if (fshR_debug) then {
	_str = format ['%1 has begun fshR init', _vehicle];
	conYellow(_str);
};


fshR_get_Playing = compileFinal "
	if (!_hud_showing) exitWith {};
	'radio_hud' cutText ['', 'PLAIN'];
	_hud_showing = false;
";

_sleepTIme = 1;

_lastDj = [];

_fnc_songProgress = {
	if (_vSong != '' && _vSongTime >= 0) then {
		//We have a song, see if its over yet.
		INC_A(_vSongTime, _sleepTIme);
		_vSongEnd = _vSong call fsh_getTrackDuration;
		if (_vSongEnd < 1) then {_vSongEnd = DEF_SONG_LENTGH;}; 
		if (_vSongTime >= _vSongEnd) then {
			_vSong = fsh_music call bis_fnc_selectRandom;
			_vSongTime = 0;
		};
	};
};

_idle_time = 0;

while {alive _vehicle && _idle_time < SHUTDOWN_TIME} do {

	_ps_in_veh = [];
	{ 
		if (isPlayer _x) then {
			_ps_in_veh pushBack _x;
		};
	} forEach (crew _vehicle);
	
	_nearest =  _vehicle nearEntities ["Man", AUDIO_DISTANCE];
	_ps_closeby = [];
	{
		if (isPlayer _x) then {
			_ps_closeby pushBack _x;
		};
	} forEach _nearest;
	
	if (count _ps_in_veh > 0 || count _ps_closeby > 0) then {
		//There are players in this vehicle
		_idle_time = 0;
		//check to see if anyone has sent us a command
		_vData = _vehicle getVariable ['fshR_data',[]];
		if (count _vData > 0) then {
			_vehicle setVariable ['fshR_data',[],true];
			_command = _vData select 0;
			switch (_command) do {
				case 'stop': {
					_vSongTime = -1;
				};
				case 'back': {
					_vSongTime = 0;
				};
				case 'next': {
					_vSong = fsh_music call bis_fnc_selectRandom;
					_vSongTime = 0;
				};
				case 'play': {
					if (_vSong == '') then {_vSong = fsh_music call bis_fnc_selectRandom;};
					//Put the song back a second to account for inevitable network delay
					if (_vSongTime != -1) then {
						_vSongTime = (abs _vSongTime)-1; DENEG(_vSongTime);	
					} else {
						_vSongTime = 0;
					};
				};
				case 'pause': {
					//This is clever. if a time is negative, the music is paused. Using 'abs' command will put it back and it will play again. 
					_vSongTime = 0 - _vSongTime;
				};
				case 'track_select': {
					_mode = 1;
					disableSerialization;
					_track = [_vData,1,'',['']] call BIS_fnc_param;
					_vSongTime = 0;
					_vSong = _track;
				};
				case 'track_time': {
					_time_percent = [_vData,1,0,[0]] call BIS_fnc_param;
					_time = floor (_time_percent*(_vSongEnd/100));
					_vSongTime = _time;
				};
				case 'station_select': {
					_mode = 2;
					_station = _vData select 1;
				};
				case 'mode': {
					_mode = _vData select 1;
				};
				case 'off': {
					//Send players dead data
					_vehicle setVariable ["fsh_vehicleRadio", [0, '', -1], true];
					if (count _ps_in_veh > 0) then { 
						{
							_clientID = owner _x;
							fsh_vehicleRadioData = [0, '', -1];
							_clientID publicVariableClient "fsh_vehicleRadioData";
						} forEach _ps_in_veh;		
					};
					if (count _ps_closeby > 0) then { 
						/*
						{ 
							_clientID = owner _x;
							scopeName "closeby";
							// are we closest playing?
							_closest_vehicles = _vehicle nearEntities ["AllVehicles", 50];
							_dist = _x distance _vehicle;
							_pl = _x;
							closest = true;
							{
								if (_x getVariable ['fshR_vehInit', 0] == 2 && _dist > (_pl distance _x)) then {
									// we are closer so play
									closest = false;
								};
							} forEach _closest_vehicles;
							if (closest) then {
								fsh_vehicleRadioData = [0, '', -1];
								_clientID publicVariableClient "fsh_vehicleRadioData";
							};
						} forEach _ps_closeby;
						*/
						//_vehicle setVariable ["fsh_vehicleRadio", [0, '', -1], true];
					};
					breakTo "main";
					
				};
				default {
					hint (call fsh_getErrorMessage);
				};
			};
		};
		
		if (_mode == 1) then {
			//manage what is playing. Please replace this later :)
			call _fnc_songProgress;
			_vehicle setVariable ["fsh_vehicleRadio", [_mode, _vSong, _vSongTime], true];
			if (count _ps_in_veh > 0) then {  
				{ 
					//This crew member is a player, so we should send them sweet sweet music
					_clientID = owner _x;
					fsh_vehicleRadioData = [_mode, _vSong, _vSongTime];
					_clientID publicVariableClient "fsh_vehicleRadioData";
				} forEach _ps_in_veh;
			};
			
			if (count _ps_closeby > 0) then {  
			/*
				{ 
					_clientID = owner _x;
					scopeName "closeby";
					// are we closest playing?
					_closest_vehicles = _vehicle nearEntities ["AllVehicles", 50];
					_dist = _x distance _vehicle;
					_pl = _x;
					closest = true;
					{
						if (_x getVariable ['fshR_vehInit', 0] == 2 && _dist > (_pl distance _x)) then {
							// we are closer so play
							closest = false;
						};
					} forEach _closest_vehicles;
					if (closest) then {
						fsh_vehicleRadioData = [_mode, _vSong, _vSongTime];
						_clientID publicVariableClient "fsh_vehicleRadioData";
					};
				} forEach _ps_closeby;
				*/
				
			};
			
			
			//Send DJ data
			
			//Check every second because people play with knobs
			_sleepTIme = 1;
		} else {
			_vehicle setVariable ["fsh_vehicleRadio", [_mode, _station, -1], true];
			
			if (count _ps_in_veh > 0) then {
				//Send Radio Data
				{ 
					_clientID = owner _x;
					fsh_vehicleRadioData = [_mode, _station, -1];
					_clientID publicVariableClient "fsh_vehicleRadioData";
				} forEach _ps_in_veh;
			};
			if (count _ps_closeby > 0) then {
				 
				
				
				/*
				{ 
					_clientID = owner _x;
					scopeName "closeby";
					// are we closest playing?
					_closest_vehicles = _vehicle nearEntities ["AllVehicles", 50];
					_dist = _x distance _vehicle;
					_pl = _x;
					closest = true;
					{
						if (_x getVariable ['fshR_vehInit', 0] == 2 && _dist > (_pl distance _x)) then {
							// we are closer so play
							closest = false;
						};
					} forEach _closest_vehicles;
					if (closest) then {
						fsh_vehicleRadioData = [_mode, _station, -1, _vehicle];
						_clientID publicVariableClient "fsh_vehicleRadioData";
					};
				} forEach _ps_closeby;
				*/
			};
			
			
			
			//As the radio is not going to change, reduce the loop intensity
			_sleepTIme = LONG_SLEEP;
		};
	} else {
		//No one in the vehicle
		_sleepTIme = LONG_SLEEP;
		INC(_idle_time);
		if (_mode == 1) then {
			//Keep time running
			call _fnc_songProgress;
			_vehicle setVariable ["fsh_vehicleRadio", [_mode, _vSong, _vSongTime], true];
		};
	};
	uiSleep _sleepTIme;
};

_vehicle setVariable ['fshR_vehInit', 0, true];
_data = [_mode, _station, _vSong, _vSongTime];
_vehicle setVariable ['fshR_vrd', _data, false];

if (fshR_debug) then {
	_str = format ['%1 has ended fshR, storing data %2', _vehicle, _data];
	conRed(_str);
};
