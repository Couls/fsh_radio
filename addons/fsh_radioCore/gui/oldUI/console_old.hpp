#define CONSOLE_X 0.1
#define CONSOLE_Y 0.2
#define CONSOLE_W 0.6
#define CONSOLE_H 0.4



#define MICRO_OFFSET (1/250)

#define LIST_W 0.3
#define LIST_H 0.8

#define BUTTON_W CONSOLE_W/4
#define BUTTON_H CONSOLE_W/12

#define BUTTON_CLOSE 		x = CONSOLE_X + CONSOLE_W - BUTTON_W; 	y = CONSOLE_Y; 	w = BUTTON_W; 	h = BUTTON_H







#define LIST_TITLE 				x = CONSOLE_X;		y = CONSOLE_Y + BUTTON_H; 		w = CONSOLE_W/2; h = BUTTON_H
#define LIST 					x = CONSOLE_X;		y = CONSOLE_Y + (2*BUTTON_H); 	w = CONSOLE_W/2; h = CONSOLE_H - (2.5*BUTTON_H)


#define BUTTON(_x,_y)			x = CONSOLE_X + (CONSOLE_W/2) + (_x * BUTTON_W); y =  CONSOLE_Y + BUTTON_H + (_y * BUTTON_H); w = BUTTON_W; h = BUTTON_H
#define BUTTON_WH(_x,_y,_w,_h)	x = CONSOLE_X + (CONSOLE_W/2) + (_x * BUTTON_W); y =  CONSOLE_Y + BUTTON_H + (_y * BUTTON_H); w = BUTTON_W*_w; h = BUTTON_H*_h

#define SLIDER1 				x = CONSOLE_X; y =  CONSOLE_Y + CONSOLE_H - (0.5*BUTTON_H); w = CONSOLE_W; h = BUTTON_H/2



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
		class fshR_RscTitleBackground : FSH_RscText 
		{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.3843])", "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.7019])", "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.8862])", "(profilenamespace getvariable ['GUI_BCG_RGB_A',0.7])"};
			sizeEx = 0.032;
			text = "";
			idc = -1;
			moving = true;
			x = CONSOLE_X;
			y = CONSOLE_Y;
			w = CONSOLE_W;
			h = BUTTON_H;
		};
		class fshR_MainBackground : FSH_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = CONSOLE_X;
			y = CONSOLE_Y + BUTTON_H;
			w = CONSOLE_W;
			h = CONSOLE_H - BUTTON_H;
		};
		class fshR_background_listHeader : FSH_RscText {
			colorBackground[] = {0.2, 0.2, 0.2, 1};
			idc = -1;
			LIST_TITLE;
		};
		class fshR_background_timer : FSH_RscText {
			colorBackground[] = {0.2, 0.2, 0.2, 1};
			idc = -1;
			BUTTON_WH(0,5.5,2,1);
		};
	}; 
	class controls 
	{
		
		//////////////////////////////////////  ID CLASSES   /////////////////////////////////////////////////
		class fshR_title : FSH_RscText 
		{
			idc = 7150;
			//colorBackground[] = {0, 0,0, 0};
			sizeEx = 0.032;
			text = "FSH R01 Tuner";
			moving = true;
			x = CONSOLE_X;
			y = CONSOLE_Y;
			w = CONSOLE_W - BUTTON_W;
			h = BUTTON_H;
		};
		
		class fshR_list_title : FSH_RscText 
		{
			idc = 7151;
			//colorBackground[] = {0, 0,0, 0};
			sizeEx = 0.032;
			text = "Songs";
			
			moving = true;
			LIST_TITLE;
		};
		
		class fshR_info_title : FSH_RscText 
		{
			idc = 7152;
			//colorBackground[] = {0, 0,0, 0};
			sizeEx = 0.032;
			text = "Song";
			moving = true;
			BUTTON_WH(0,1.25,2,1);
		};
		class fshR_info_artist : FSH_RscText 
		{
			idc = 7153;
			//colorBackground[] = {0, 0,0, 0};
			sizeEx = 0.032;
			text = "Artist";
			moving = true;
			BUTTON_WH(0,2.25,2,1);
		};
		class fshR_info_songTime : FSH_RscText 
		{
			idc = 7154;
			//colorBackground[] = {0, 0,0, 0};
			sizeEx = 0.032;
			text = "0:00";
			
			moving = true;
			BUTTON_WH(0,5.5,1,1);
		};
		class fshR_info_songEnd : FSH_RscText 
		{
			idc = 7155;
			//colorBackground[] = {0, 0,0, 0};
			sizeEx = 0.032;
			text = "3:30";
			
			moving = true;
			BUTTON_WH(1,5.5,1,1);
		};
	
		class fshR_list : FSH_RscListBox 
		{
			idc = 7156;
			text = "";
			sizeEx = 0.028;
			onLBDblClick = "[_this, 'track_select'] call fshR_fnc_button";
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
			SLIDER1;
		};
		class fshR_list_radios : FSH_RscListBox 
		{
			idc = 7158;
			text = "";
			sizeEx = 0.028;
			onLBDblClick = "[_this, 'station_select'] call fshR_fnc_button";
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
			BUTTON_CLOSE;
		};	
		class fshR_button_play : FSH_RscButtonMenu 
		{
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "Play";
			onButtonClick = "[_this, 'play'] call fshR_fnc_button";
			BUTTON(0,4.5);
		};
		class fshR_button_pause : FSH_RscButtonMenu 
		{
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "||";
			onButtonClick = "[_this, 'pause'] call fshR_fnc_button";
			BUTTON_WH(1,4.5,0.5,1);
		};
		class fshR_button_stop : FSH_RscButtonMenu 
		{
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "[]";
			onButtonClick = "[_this, 'stop'] call fshR_fnc_button";
			BUTTON_WH(1.5,4.5,0.5,1);
		};
		class fshR_button_previous : FSH_RscButtonMenu 
		{
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "  <<";
			onButtonClick = "[_this, 'back'] call fshR_fnc_button";
			BUTTON(0,3.5);
		};
		class fshR_button_next : FSH_RscButtonMenu 
		{
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "  >>";
			onButtonClick = "[_this, 'next'] call fshR_fnc_button";
			BUTTON(1,3.5);
		};
		
		class fshR_button_dj : FSH_RscButtonMenu 
		{
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "DJ Mode";
			onButtonClick = "[_this, 'dj'] call fshR_fnc_button";
			BUTTON(0,0);
		};
		class fshR_button_fm : FSH_RscButtonMenu 
		{
			idc = -1;
			//shortcuts[] = {0x00050000 + 2};
			text = "FM Radio";
			onButtonClick = "[_this, 'fm'] call fshR_fnc_button";
			BUTTON(1,0);
		};
	};
};