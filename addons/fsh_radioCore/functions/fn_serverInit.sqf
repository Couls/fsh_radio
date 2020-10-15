if (!isServer) exitWith {};
#include "..\macros.hpp"

fshR_debug = false;

if (fshR_debug) then {
	'debug_console' callExtension ('C'); 
	conWhiteTime('Server init');
};

fshR_serverData = [];
"fshR_serverData" addPublicVariableEventHandler {
	_param = _this select 1;
	_type = _param select 0;
	if (_type == 'vehicleInit') then {
		[_param select 1] spawn fshR_fnc_vehicleLoop;
	};
};


{
	_x spawn fshR_fnc_stationInit;
} forEach fsh_stations;


_nul = [] spawn {
	_ctr  = 10;
	while {true} do {
		fsh_global_time = fsh_global_time + 1;
		if (_ctr>0) then {_ctr = _ctr -1;} else {publicVariable 'fsh_global_time'; _ctr = 10;};
		uiSleep 1;
	};
};