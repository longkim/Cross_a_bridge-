program BridgeCrossing;
uses SwinGame, sgTypes;
const
	SIDEWIDTH = 37;
	SIDEHEIGHT = 288;
type

	Alphabet = (A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z);


	CharacterData = record
		StretchSpeed,length,x,y : Integer;
		bmp: Bitmap;
		//types : CharacterType;
	end;

	GameData = record
		character : CharacterData;
		key : KeyCode;
		charBmp: Bitmap;
		x,y: Integer;
		time : Timer;
	end;



function GameKey(alphabet: Alphabet): GameData;
begin
	// Return the bitmap that matches the kind of fruit asked for
	case alphabet of 
		A:		
			begin
				result.key := vk_a; 
				result.charBmp := BitmapNamed('a');
			end;
		B:	
			begin	
				result.key := vk_b; 
				result.charBmp := BitmapNamed('b');
			end;
		C:		
			begin
				result.key := vk_c;
				result.charBmp := BitmapNamed('c');
			end;
		D:		
			begin
				result.key := vk_d;
				result.charBmp := BitmapNamed('d');
			end;
		E:		
			begin
				result.key := vk_e; 
				result.charBmp := BitmapNamed('e');
			end;
		F:		
			begin
				result.key :=  vk_f; 
				result.charBmp := BitmapNamed('f');
			end;
		G:		
			begin
				result.key := vk_g; 
				result.charBmp := BitmapNamed('g');
			end;
		H:		
			begin
				result.key := vk_h; 
				result.charBmp := BitmapNamed('h');
			end;
		I:		
			begin
				result.key := vk_i;
				result.charBmp := BitmapNamed('i');
			end;
		J:		
			begin
				result.key := vk_j;
				result.charBmp := BitmapNamed('j');
			end;
		K:		
			begin
				result.key := vk_k; 
				result.charBmp := BitmapNamed('k'); 
			end;
		L:		
			begin
				result.key := vk_l; 
				result.charBmp := BitmapNamed('l');
			end;
		M:		
			begin
				result.key := vk_m;
				result.charBmp := BitmapNamed('m');
			end;
		N:		
			begin
				result.key := vk_n; 
				result.charBmp := BitmapNamed('n');
			end;
		O:		
			begin
				result.key := vk_o; 
				result.charBmp := BitmapNamed('o');
			end;
		P:		
			begin
				result.key := vk_p; 
				result.charBmp := BitmapNamed('p');
			end;
		Q:		
			begin
				result.key := vk_q; 
				result.charBmp := BitmapNamed('q');
			end;
		R:		
			begin
				result.key := vk_r; 
				result.charBmp := BitmapNamed('r');
			end;
		S:	
			begin
				result.key := vk_s; 
				result.charBmp := BitmapNamed('s');
			end;
		T:		
			begin
				result.key := vk_t; 
				result.charBmp := BitmapNamed('t');
			end;
		U:		
			begin
				result.key := vk_u; 
				result.charBmp := BitmapNamed('u');
			end;
		V:		
			begin
				result.key := vk_v; 
				result.charBmp := BitmapNamed('v');
			end;
		W:		
			begin
				result.key := vk_w; 
				result.charBmp := BitmapNamed('w');
			end;
		X:		
			begin
				result.key := vk_x; 
				result.charBmp := BitmapNamed('x');
			end;
		Y:		
			begin
				result.key := vk_y; 
				result.charBmp := BitmapNamed('y');
			end;
		Z:		
			begin
				result.key := vk_z;
				result.charBmp := BitmapNamed('z');
			end;

	else
		result.key := vk_a;
		result.charBmp := BitmapNamed('a');	// return nil if not match any alphabet
	end;
end;

function RandomAlphabet() : GameData;
begin
	// Randomly pick one of the 26 alphabet
	result := GameKey(Alphabet(Rnd(26)));
end;


procedure DrawGame(mainGameData : GameData;x,y,bridgeX: Integer;characterMoving: Sprite);
begin
	DrawBitMap('cloud',0,0);
	DrawSprite(characterMoving );
    UpdateSprite(characterMoving );

    DrawBitMap('side',0,200);
	DrawBitMap('side',ScreenWidth()-SIDEWIDTH,200);
	//DrawBitMap('bridge',bridgeX+16,200);
	//DrawBitMap('bridge',bridgeX+32,200);
	//DrawBitMap('bridge',bridgeX,200);
	DrawBitMap(mainGameData.charBmp,mainGameData.x,mainGameData.y);
	DrawBitMapPart(BitmapNamed('bridge1'),80,0,bridgeX,16,SIDEWIDTH,200);

	SpriteSetX(characterMoving ,x);
	SpriteSetY(characterMoving ,y);
	
	

    RefreshScreen(40);
end;



procedure UpdateGame(var x,y,bridgeX,gamespeed: Integer);
var
	playSound: Integer;
begin
	if (x < ScreenWidth() - 65) then
		begin
			x := x + gamespeed;
		end;

	if KeyTyped(vk_UP) then
		begin

		end;	
	playSound := 0;
	if(x > bridgeX) then
		begin
			
			if(playSound = 0) then 
	
			y := y + gamespeed*5;
			if(y > ScreenHeight()) then
			begin
				x := 0;
				y := 165;
				bridgeX := SIDEWIDTH;
			end;
		end;
end;

procedure HandleInput(var mainGameData :GameData;var x,bridgeX:Integer;var gameWin: Boolean);
begin
	if KeyTyped(mainGameData.key) and (x < bridgeX) then
		begin
			PlaySoundEffect('Type');
			mainGameData := RandomAlphabet();
			mainGameData.x := (Rnd(ScreenWidth() - BitmapWidth(mainGameData.charBmp)));
			mainGameData.y := (Rnd(100));
			//DrawBitMapPart(BitmapNamed('bridge1'),100,100,100,100,bridgeX,200);
			if (bridgeX < ScreenWidth() - 2*SIDEWIDTH) then
				begin
					bridgeX := bridgeX + 32;
				end
			else 
				begin
					gameWin := true;
				end;
		end;
end;

procedure LevelSelect();
begin
	DrawBitMap('cloud',0,0);
	DrawText ('Please Choose The Difficulty For the Game',ColorBlack,'gamefont',200,100);
	DrawText ('1. Easy',ColorBlack,'gamefont',250,120);
	DrawText ('2. Medium',ColorBlack,'gamefont',250,140);
	DrawText ('3. Hard',ColorBlack,'gamefont',250,160);
end;

procedure Main();
var
	characterMoving : Sprite;
	bridgeX,x,y,gamespeed: Integer;
	mainGameData: GameData;
	gameBegin,gameWin: boolean;

begin
	OpenAudio();
	gameBegin := false;
	OpenGraphicsWindow('Bridge', 705, 344);
	LoadMusicNamed('music','HarvestMoonBackToNature.mp3');
	LoadSoundEffectNamed('Fall', 'fall.wav');
	LoadSoundEffectNamed('Type', '3.wav');
	PlayMusic('music',-1);
	SetMusicVolume(0.5);
	LoadDefaultColors();
	// LoadResources();
	LoadResourceBundle('character.txt' );
	characterMoving := CreateSprite(BitmapNamed('sprite')  ,AnimationScriptNamed('Moving' )  );
	SpriteStartAnimation(characterMoving,'Moving');

	mainGameData := RandomAlphabet();
	mainGameData.x := (Rnd(ScreenWidth()));
	mainGameData.y := (Rnd(100));
	x := 0;
	y := 165;
	bridgeX := SIDEWIDTH;
    SpriteSetX(characterMoving ,x);
    SpriteSetY(characterMoving ,y);
	
	//loop the game 
	repeat
		ProcessEvents();

		//Level Choice
		repeat
			ProcessEvents();
			ClearScreen(ColorWhite);
			//Level select interface
			LevelSelect();
			RefreshScreen(60);

			//Event handle for difficulty
			if (KeyTyped(vk_1)) then 
			begin
				gamespeed := 1;
				gameBegin := true;
			end;
			if (KeyTyped(vk_2)) then 
			begin
				gamespeed := 2;
				gameBegin := true;
			end;
			if (KeyTyped(vk_3)) then 
			begin
				gamespeed := 3;
				gameBegin := true;
			end;
		until (WindowCloseRequested() or gameBegin);
		gameWin := false;
		
		//real game begin
		repeat
			ProcessEvents();
			UpdateGame(x,y,bridgeX,gamespeed);
			HandleInput(mainGameData,x,bridgeX,gameWin);
			DrawGame(mainGameData,x,y,bridgeX,characterMoving);
			
		until (WindowCloseRequested() or gameWin );

		//reset the value
		gameBegin := false;
		x := 0;
		y := 165;
		bridgeX := SIDEWIDTH;
	until(WindowCloseRequested());
	ReleaseAllResources();
end;

begin
	Main();
end.
