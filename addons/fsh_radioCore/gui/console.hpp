#define DEFAULT x = -10; y = -10; w = 1; h = 1

#define CONSOLE_X 0
#define CONSOLE_Y 0
#define CONSOLE_W 1
#define CONSOLE_H 1

#define SCREEN_X	CONSOLE_X + CONSOLE_W/4.3
#define SCREEN_Y	CONSOLE_Y + CONSOLE_H/3.05
//3.05
#define SCREEN_W	CONSOLE_W/1.86
#define SCREEN_H	CONSOLE_H/3.15
#define SCREEN_C	0, 0.5, 0.1, 1

#define BUTTON_W CONSOLE_W/9
#define BUTTON_H CONSOLE_H/18


#define SKIN	"fsh_radioCore\gui\fsh_ui_radio.paa"

#define TITLE		x = SCREEN_X+ (SCREEN_W*0.51); y = SCREEN_Y + (SCREEN_H*0.1); w = SCREEN_W*0.48; h = SCREEN_H*0.4
#define ARTIST		x = SCREEN_X+ (SCREEN_W*0.51); y = SCREEN_Y + (SCREEN_H*0.25); w = SCREEN_W*0.48; h = SCREEN_H*0.5
#define TIME		x = SCREEN_X+ (SCREEN_W*0.51); y = SCREEN_Y + (SCREEN_H*0.5); w = SCREEN_W*0.2; h = SCREEN_H*0.4
#define END			x = SCREEN_X+ (SCREEN_W*0.71); y = SCREEN_Y + (SCREEN_H*0.5); w = SCREEN_W*0.2; h = SCREEN_H*0.4
#define LIST_TITLE	DEFAULT

#define PLAY		x = CONSOLE_X + (CONSOLE_W*0.03); 	y = CONSOLE_Y+CONSOLE_H/1.96; 	w = BUTTON_W; 	h = BUTTON_H
#define PAUSE		x = CONSOLE_X + (CONSOLE_W*0.04); 	y = CONSOLE_Y+CONSOLE_H*0.58; 	w = BUTTON_W; 	h = BUTTON_H
#define STOP		x = CONSOLE_X + (CONSOLE_W*0.06); 	y = CONSOLE_Y+CONSOLE_H*0.64; 	w = BUTTON_W; 	h = BUTTON_H
#define NEXT		x = CONSOLE_X + (CONSOLE_W*0.86); 	y = CONSOLE_Y+CONSOLE_H/2.55; 	w = BUTTON_W; 	h = BUTTON_H
#define BACK		x = CONSOLE_X + (CONSOLE_W*0.865); 	y = CONSOLE_Y+CONSOLE_H/2.2; 	w = BUTTON_W; 	h = BUTTON_H
#define AUX			x = CONSOLE_X + (CONSOLE_W*0.08); 	y = CONSOLE_Y+CONSOLE_H*0.7; 	w = BUTTON_W; 	h = BUTTON_H
#define RADIO		x = CONSOLE_X + (CONSOLE_W*0.85); 	y = CONSOLE_Y+CONSOLE_H/3; 	w = BUTTON_W; 	h = BUTTON_H
#define CLOSE 		x = CONSOLE_X + (CONSOLE_W*0.87); 	y = CONSOLE_Y+CONSOLE_H/4.3; 	w = BUTTON_W*0.7; 	h = BUTTON_H*1.05

#define LIST 		x = SCREEN_X; y = SCREEN_Y; w = SCREEN_W/2; h = SCREEN_H
#define SLIDER		x = SCREEN_X - (SCREEN_W*0.11); y = CONSOLE_Y + (CONSOLE_H*0.25); w = SCREEN_W + (SCREEN_W*0.22); h = BUTTON_H*0.4



class fshR_console 
{ 
	idd = 715; // set to -1, because we don't require a unique ID 
	movingEnable = true; // the dialog can be moved with the mouse (see "moving" below) 
	enableSimulation = true; // freeze the game 
	objects[] = { }; // no objects needed 
	onLoad = "uiNamespace setVariable ['fshR_Console', _this select 0];";
	onUnLoad = "call fshR_close";
	class controlsBackground 
	{ 
		class fshR_background_skin : FSH_RscPicture {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			text=SKIN;
			x = CONSOLE_X;
			y = CONSOLE_Y;
			w = CONSOLE_W;
			h = CONSOLE_H;
		};
		class fshR_background_screen : FSH_RscText {
			colorBackground[] = {SCREEN_C};
			style = 0;
			idc = -1;
			x = SCREEN_X;
			y = SCREEN_Y;
			w = SCREEN_W;
			h = SCREEN_H;
		};
	}; 

	class controls 
	{
		
		//////////////////////////////////////  ID CLASSES   /////////////////////////////////////////////////
		class fshR_list_title : FSH_RscText 
		{
			idc = 7151;
			//colorBackground[] = {0, 0,0, 0};
			sizeEx = 0.064;
			text = "Songs";
			
			moving = true;
			LIST_TITLE;
		};
		
		class fshR_info_title : FSH_RscText 
		{
			idc = 7152;
			//colorBackground[] = {0, 0,0, 0};
			sizeEx = 0.032;
			text = "";
			moving = true;
			TITLE;
		};
		class fshR_info_artist : FSH_RscText 
		{
			idc = 7153;
			//colorBackground[] = {0, 0,0, 0};
			sizeEx = 0.048;
			text = "";
			moving = true;
			ARTIST;
		};
		class fshR_info_songTime : FSH_RscText 
		{
			idc = 7154;
			//colorBackground[] = {0, 0,0, 0};
			sizeEx = 0.056;
			text = "";
			moving = true;
			TIME;
		};
		class fshR_info_songEnd : FSH_RscText 
		{
			idc = 7155;
			style = 1;
			//colorBackground[] = {0, 0,0, 0};
			sizeEx = 0.056;
			text = "";
			moving = true;
			END;
		};
	
		class fshR_list : FSH_RscListBox 
		{
			idc = 7156;
			text = "";
			colorBackground[] = {SCREEN_C};
			sizeEx = 0.032;
			onLBDblClick = "[_this, 'track_select'] call fshR_fnc_button";
			onLBSelChanged = "[_this, 'track_changed'] call fshR_fnc_button";
			LIST;
		};
		class fshR_song_slider : FSH_RscSlider
		{
			idc = 7157;
			text = "";
			//onSliderPosChanged = "['COLOURR',_this select 1] call fshRliderChange";
			onSliderPosChanged = "[_this, 'track_time'] call fshR_fnc_button";
			tooltip = "";
			color[] = {1, 1, 1, 0.7};
			colorActive[] = {1, 1, 1, 1};
			colorDisabled[] = {0.8, 0.8, 0.8, 0.500000};
			SLIDER;
		};
		class fshR_list_radios : FSH_RscListBox 
		{
			idc = 7158;
			text = "";
			colorBackground[] = {SCREEN_C};
			sizeEx = 0.046;
			onLBDblClick = "[_this, 'station_select'] call fshR_fnc_button";
			onLBSelChanged = "[_this, 'station_changed'] call fshR_fnc_button";
			LIST;
		};
		/////////////////////////////////////////////   NON ID CLASSES    //////////////////////////////////////////////////
		class fshR_button_close : FSH_RscButtonMenu 
		{
			idc = -1;
			colorBackground[] = {1, 0, 0, 0.9};
			//shortcuts[] = {0x00050000 + 2};
			sizeEx = 0.55;
			text = "X";
			onButtonClick = "[_this, 'close'] call fshR_fnc_button";
			CLOSE;
		};	
		class fshR_button_play : FSH_RscButtonMenu 
		{
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "Play";
			onButtonClick = "[_this, 'play'] call fshR_fnc_button";
			PLAY;
		};
		class fshR_button_pause : FSH_RscButtonMenu 
		{
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "||";
			onButtonClick = "[_this, 'pause'] call fshR_fnc_button";
			PAUSE;
		};
		class fshR_button_stop : FSH_RscButtonMenu 
		{
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "[]";
			onButtonClick = "[_this, 'stop'] call fshR_fnc_button";
			STOP;
		};
		class fshR_button_previous : FSH_RscButtonMenu 
		{
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "  <<";
			onButtonClick = "[_this, 'back'] call fshR_fnc_button";
			BACK;
		};
		class fshR_button_next : FSH_RscButtonMenu 
		{
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "  >>";
			onButtonClick = "[_this, 'next'] call fshR_fnc_button";
			NEXT;
		};
		
		class fshR_button_dj : FSH_RscButtonMenu 
		{
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "DJ Mode";
			onButtonClick = "[_this, 'dj'] call fshR_fnc_button";
			AUX;
		};
		class fshR_button_fm : FSH_RscButtonMenu 
		{
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "FM Radio";
			onButtonClick = "[_this, 'fm'] call fshR_fnc_button";
			RADIO;
		};
	};
};