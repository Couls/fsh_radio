if (!isServer) exitWith {}; //Server does not see the need for such trifles
#include "..\macros.hpp"
private ["_name","_class", "_base_radio_cfg", "_mission_radio_cfg", "_radio_cfg", "_program", "_debug", "_categories", "_cat_i", "_cat", "_cat_name", "_cat_tracks", "_cat_artists", "_cat_types", "_cat_themes", "_track_duration", "_item", "_new_track", "_arr", "_i"];
_class = _this;
_base_radio_cfg = configFile >> 'CfgRadioStations' >> _class;
_mission_radio_cfg = missionConfigFile >> 'CfgRadioStations' >> _class;
_radio_cfg = _base_radio_cfg;
_name = getText (_base_radio_cfg >> 'name');
_radio_var = format ['fshR_%1', _class];
if (_name == '') then {
	_name = getText (_mission_radio_cfg >> 'name');
	_radio_cfg = _mission_radio_cfg;
};

if (_name == '') exitWith {hint (call fsh_getErrorMessage)};	//This Radio station doesn't have a config entry- try a real one next time.
//Get radio station format
_program = (_radio_cfg >> 'program') call BIS_fnc_GetCfgData;
_timeSpeed = (_radio_cfg >> 'Speed') call BIS_fnc_GetCfgData;
_debug = if (((_radio_cfg >> 'debug') call BIS_fnc_GetCfgData) == 1) then {true} else {false};



//Get all track categories
_categories = [];

for [{_cat_i=0}, {_cat_i < (count _radio_cfg) && _cat_i < 30}, {_cat_i = _cat_i + 1}] do {
	_cat = _radio_cfg select _cat_i;
	if (count _cat > 0) then {
		_cat_name = configName _cat;
		_cat_tracks = getArray (_cat >> 'tracks');
		_cat_types = getArray (_cat >> 'types');
		_cat_themes = getArray (_cat >> 'themes');
		_search_results = ([_cat_types,_cat_themes,fsh_tracks] call fshR_fnc_getTracks) - _cat_tracks;
		_cat_all_tracks = _cat_tracks + _search_results;
		_cat_all_tracks = _cat_all_tracks call fsh_arrayShuffle;
		if (count _cat_all_tracks ==0) then {
			_str = format['Error: %1 found 0 results for class %2', _name, _cat_name];
			conRed(_str); diag_log _str;
		};
		_categories pushBack [_cat_name, _cat_all_tracks];
	};
};

if (_debug) then {
	diag_log format['============ %1 ==============', _name];
	diag_log _radio_var;
	diag_log '----Program-----';
	{diag_log _x} forEach _program;
	diag_log '----categories-----';
	{diag_log _x} forEach _categories;
};
_endTime = 0;
//Now we have a program lined up, go ahead and launch
while {true} do {
	if (fsh_global_time >= _endTime) then {
		_track_duration = 1;
		//--------- Manage the program running order ----------
		_item = _program select 0;
		_new_track = '';
		_program = _program call fsh_arrayCycle;
		//-----------------------------------------------------
		//WE have an _item, now look up its cat and pick a track
		for "_i" from 0 to (count _categories min 10) do {
			_curr_cat = _categories select _i;
			_catName = _curr_cat select 0;
			if (_catName == _item) exitWith {
				_tracks = _curr_cat select 1;
				if (count _tracks > 0) then {
					//Pick the first one from the list
					_new_track = _tracks select 0;
					_track_duration = _new_track call fsh_getTrackDuration;
					//Update the list for next time
					_tracks = _tracks call fsh_arrayCycle;
					_curr_cat set [1, _tracks];
					_categories set [_i, _curr_cat];
				};
				
			};
		};
		if (_track_duration < 1) then {_track_duration = 4;};
		
		_current_time = floor (call fsh_getTime);
		_endTime = _current_time + _track_duration;
		
		
		missionnameSpace setVariable [_radio_var, [_new_track, _current_time, _endTime], true];
	};
	sleep 2;
};
_program = (_radio_cfg >> 'program') call BIS_fnc_GetCfgData;