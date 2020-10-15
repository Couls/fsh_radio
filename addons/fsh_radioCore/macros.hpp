#define IS_GOD							player allowDamage false; player setCaptive true
#define IS_MORTAL						player allowDamage true; player setCaptive false

#define EXIT							if (true) exitWith {}
#define PASS_PARAM(_par,_arr)			if (_par in _arr) then {true} else {false}
#define PASS_PARAM_I(_parStr,_parArr)	if (_parStr in _parArr) then {false} else {true}
#define PARSE_PARAM(_parStr)			if (_parStr in _params) then {false} else {true} //use this if your params are saved under "_params". 
#define LAST(_var) 						((count _var)-1)
#define GET_LAST(_varr)					_varr select LAST(_varr)
#define INC(_a)							_a = _a +1
#define INC_A(_a,_b)					_a = _a + _b
#define DEC(_a)							_a = _a -1
#define DEC_A(_a,_b)					_a = _a - _b
#define RND_INT							random(999999)
#define DENEG(_a)						if (_a < 0) then {_a = 0}

#define X(A)							[A,0,-1,[0]] call BIS_fnc_param
#define Y(A)							[A,1,-1,[0]] call BIS_fnc_param
#define Z(A)							[A,2,-1,[0]] call BIS_fnc_param
#define DIST_X(A,B) 					abs ((A select 0) - (B select 0))
#define DIST_Y(A,B) 					abs ((A select 1) - (B select 1))
#define DIST_M(A,B) 					(abs ((A select 0) - (B select 0))) + (abs ((A select 1) - (B select 1)))

#define SERVER_SIDE						if (!isServer) exitWith {}
#define DEDICATED_SIDE					if (!isDedicated) exitWith {}
#define PLAYER_SIDE						if (isDedicated) exitWith {}
#define INIDB_BREAK						if (!iniDB) exitWith {}
#define FPW_BREAK						if (isNil "FPW_RUNNING") exitWith {}
#define VMS_BREAK						if (isNil "VMS_RUNNING") exitWith {}
#define CHECK_FPW_RUNNING				(!isNil "FPW_RUNNING")

#define WHILE_LIMIT						600

#define DRAW_GRID(A,B,C) \
	_marker_w = (B select 0) - (A select 0); \
	_marker_h = (B select 1) - (A select 1); \
	_marker_pos_x = (A select 0) + (_marker_w/2); \
	_marker_pos_y = (A select 1) + (_marker_h/2); \
	_mrk = createMarker [(format['mm_%1_%2_%3',A,B,random(999999)]), [_marker_pos_x,_marker_pos_y]]; \
	_mrk setMarkerShape "RECTANGLE"; \
	_mrk setMarkerSize [_marker_w/2, _marker_h/2]; \
	_mrk setMarkerColor (C)
	

#define ARR_CYCLE(ARRAY) \
	ARRAY_NEW = [];\
	for [{ARRAY_I=1}, {ARRAY_I < (count ARRAY)}, {ARRAY_I = ARRAY_I + 1}] do { \
		ARRAY_NEW pushBack (ARRAY select ARRAY_I); \
	}; \
	ARRAY_NEW pushBack (ARRAY select 0); \
	ARRAY = ARRAY_NEW

	
#define AUDIO_DISTANCE					100
	
	
/*
	KK's debug_console v3.0 macros
	http://killzonekid.com
	
	USAGE:
	
	#include "debug_console.hpp"
	conBeep(); //makes console beep
	conClear(); //clears console screen
	conClose(); //closes console, resets logfile filename
	conWhite("This Line Is White");
	conWhiteTime("This White Line Has Timestamp");
	conRed("This Line Is Red");
	conRedTime("This Red Line Has Timestamp");
	conGreen("This Line Is Green");
	conGreenTime("This Green Line Has Timestamp");
	conBlue("This Line Is Blue");
	conBlueTime("This Blue Line Has Timestamp");
	conYellow("This Line Is Yellow");
	conYellowTime("This Yellow Line Has Timestamp");
	conPurple("This Line Is Purple");
	conPurpleTime("This Purple Line Has Timestamp");
	conCyan("This Line Is Cyan");
	conCyanTime("This Cyan Line Has Timestamp");
	conFile("This Line Is Written To Logfile");
	conFileTime("This Written To Logfile Line Has Timestamp");
	diag_log ("debug_console" callExtension ("i")); //max_output_size
*/

#define conBeep() "debug_console" callExtension ("A")
#define conClear() "debug_console" callExtension ("C")
#define conClose() "debug_console" callExtension ("X")
#define conWhite(_msg) "debug_console" callExtension (_msg + "#1110")
#define conWhiteTime(_msg) "debug_console" callExtension (_msg + "#1111")
#define conRed(_msg) "debug_console" callExtension (_msg + "#1000")
#define conRedTime(_msg) "debug_console" callExtension (_msg + "#1001")
#define conGreen(_msg) "debug_console" callExtension (_msg + "#0100")
#define conGreenTime(_msg) "debug_console" callExtension (_msg + "#0101")
#define conBlue(_msg) "debug_console" callExtension (_msg + "#0010")
#define conBlueTime(_msg) "debug_console" callExtension (_msg + "#0011")
#define conYellow(_msg) "debug_console" callExtension (_msg + "#1100")
#define conYellowTime(_msg) "debug_console" callExtension (_msg + "#1101")
#define conPurple(_msg) "debug_console" callExtension (_msg + "#1010")
#define conPurpleTime(_msg) "debug_console" callExtension (_msg + "#1011")
#define conCyan(_msg) "debug_console" callExtension (_msg + "#0110")
#define conCyanTime(_msg) "debug_console" callExtension (_msg + "#0111")
#define conFile(_msg) "debug_console" callExtension (_msg + "~0000")
#define conFileTime(_msg) "debug_console" callExtension (_msg + "~0001")
	
	