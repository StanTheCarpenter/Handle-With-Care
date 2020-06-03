pico-8 cartridge // http://www.pico-8.com
version 27
__lua__
--credits
credits = {}

function credits.init()
	cls()
end

function credits.update()
		if btn(❎) then game.init(); set_state(kamer) end
end

function credits.draw()
	cls()
		spr(80,56+5,71)
		spr(81,64+5,71)

		spr(86,40+5,71)
		spr(87,48+5,71)

		i = flr(2*time()%2)
if i == 0 then

 		--stan
   spr(64,56+5,63)
   spr(65,64+5,63)

   --krampus
   spr(70,40+5,63)
   spr(71,48+5,63)

elseif i == 1 then

		--stan
  spr(66,56+5,63)
  spr(67,64+5,63)

  --krampus
		spr(72,40+5,63)
  spr(73,48+5,63)

end

	local s = 128/3+5
	local t = 128/3+2
	print("made by",s+1,t+1)
	print("krampus",s+1,t+7)
	print(" & stan",s+1,t+13)

end
-->8
--main

state = credits

function set_state(new_state)
	state = new_state
	state.init()
end

function _init()
state.init()
end

function _update()
state.update()
end

function _draw()
state.draw()
end
-->8
--game
game = {}

function game.init()
	player.init()
	items_init()
	hud_h = 5*8
end

function next_day()
	for k,v in pairs(player.stats) do
		if v.val > 0 then v.val -= 1 end
		set_spoons()
	end
	for k,v in pairs(items) do
		if v.room == 1 then
			if v.mode then v.mode = 1 end
		end
	end
end

function set_cam()
	cam = {}
	cam.x = flr((128-lvl.w*8)/2)
	cam.y = flr(((128-hud_h)-lvl.h*8)/2)
end

function game.update()
	player.update()
end

function game.draw()
	cls()
	map(lvl.x,lvl.y,cam.x,cam.y,lvl.w,lvl.h)
	map(0,11,0,11*8,16,5)
	spr(player.img,player.x+cam.x,player.y+cam.y)
	for k,v in pairs(items) do
		if v.room == room then
		spr(v.img[v.mode or 1],v.x+cam.x,v.y+cam.y)
		end
	end
	
	for i=1, player.spoons do
		spr(11,i*8,128-36)
	end
	
	for a,b in pairs(player.stats) do
		for k,v in pairs(b.s) do
			local x = flr(a/3)*5*8
			local y = a%3
			local scolor = 11
			if b.free then scolor = 8 end
			print(v,x+k*4,128-8-8*y,5)
			if k <= b.val then
				print(v,x+k*4,128-8-8*y,scolor)
			end
		end
	end
end
-->8
--items

items = {}

function items_init()
items[1] = {
	img = {17,33},
	x = 1,
	y = 2*8,
	mode = 1,
	room = 1,
	stats = player.water, 
	spoon = 1,
	act = function() player.stats[player.water].val += 3 end
	}
items[2] = {
	img = {18,34},
	x = 1,
	y = 4*8,
	mode = 1,
	room = 1,
	stats = player.sport,
	spoon = 1,
	act = function() player.stats[player.sport].val += 3 end
	}
items[3] = {
	img = {20,36},
	x = 1,
	y = 6*8,
	mode = 1,
	room = 1,
	stats = player.clean,
	spoon = 1,
	act = function() player.stats[player.clean].val += 3 end
	}
items[4] = {
	img = {21,37},
	x = 4*8,
	y = 2*8,
	mode = 1,
	room = 1,
	stats = player.foods,
	spoon = 1,
	act = function() player.stats[player.foods].val += 3 end
	}
items[5] = {
	img = {22,38},
	x = 4*8,
	y = 4*8,
	mode = 1,
	room = 1,
	stats = player.study,
	spoon = 1,
	act = function() player.stats[player.study].val += 3 end
	}
items[6] = {
	img = {26,26},
	x = 5*8,
	y = 5*8,
	room = 1,
	spoon = 0,
	act = function() set_state(kas) end
	}
items[7] = {
	img = {26,26},
	x = 0*8,
	y = 8*8,
	room = 2,
	spoon = 0,
	act = function() set_state(kamer) end
	}
items[8] = {
	img = {48,49,50,rnd(9)+50},
	x = 0*8,
	y = 6*8,
	room = 2,
	mode = 1,
	spoon = 0,
	act = function() end
	}
items[9] = {
	img = {48,49,50,rnd(9)+50},
	x = 0*8,
	y = 3*8,
	room = 2,
	mode = 1,
	spoon = 0,
	act = function() end
	}
items[10] = {
	img = {48,49,50,rnd(9)+50},
	x = 6*8,
	y = 3*8,
	room = 2,
	mode = 1,
	spoon = 0,
	act = function() end
	}
items[11] = {
	img = {48,49,50,rnd(9)+50},
	x = 6*8,
	y = 6*8,
	room = 2,
	mode = 1,
	spoon = 0,
	act = function() end
	}
items[12] = {
	img = {48,49,50,rnd(9)+50},
	x = 6*8,
	y = 9*8,
	room = 2,
	mode = 1,
	spoon = 0,
	act = function() end
	}
items[13] = {
	img = {35},
	x = 4*8,
	y = 6*8,
	room = 1,
	spoon = 0,
	act = function() next_day() end
	}
end
-->8
--player
player = {}
function player.init()
	player.x = 2*8
	player.y = 2*8
	player.img = 12
	player.stats = {}
	player.stats[1] = { val = 1,
	free = false,
	item = 1,
	s = {"w","a","t","e","r"}}
	player.stats[2] = { val = 2,
	free = false,
	item = 4,
	s = {"f","o","o","d","s"}}
	player.stats[3] = { val = 3,
	free = false,
	item = 3,
	s = {"c","l","e","a","n"}}
	player.stats[4] = { val = 0,
	free = false,
	item = 2,
	s = {"s","p","o","r","t"}}
	player.stats[5] = { val = 0,
	free = false,
	item = 5,
	s = {"s","t","u","d","y"}}
	
	player.water = 1
	player.foods = 2
	player.clean = 3
	player.sport = 4
	player.study = 5
	set_spoons()
	end

function set_spoons()
	player.max_spoons = flr(rnd(3))+2
	player.spoons = player.max_spoons
end

function player.update()
	for k,v in pairs(player.stats) do
		if v.val > 5 then v.val = 5 end
	end
	
	local gx = player.x
	local gy = player.y
	local moving = false
	if btn(⬅️) then
		gx = player.x - 1
		moving = true
	elseif btn(➡️) then
		gx = player.x + 1
		moving = true
	elseif btn(⬆️) then
		gy = player.y - 1
		moving = true
	elseif btn(⬇️) then
		gy = player.y + 1
		moving = true
	end
	
	local item_prsd = false
	for k,v in pairs(items) do
		local l, a = len(v.x,v.y,gx,gy)
		if l < 6 and v.room == room  then
			if (btn(❎) and not oldx) and
			(not v.mode or v.mode < #v.img) 
			and player.spoons >= v.spoon then
				v.act()
				if v.mode and v.mode < #v.img then 
				v.mode += 1 end
				if v.stats and not player.stats[v.stats].free then
					player.spoons -= v.spoon
				end
				if room == 2 and
				v.mode == #v.img then
				local highstat = {val = 0}
					for k2,s in pairs(player.stats) do
						if s.val > highstat.val and
						not s.free then
							highstat = s
						end
					end
					highstat.free = true
				end
			end
			item_prsd = true		
		end
	end
	
	if not item_prsd and
	fget(mget(lvl.x+flr(gx/8),lvl.y+flr(gy/8)),0) and
	fget(mget(lvl.x+flr(gx/8),lvl.y+flr(gy/8)+1),0) and
	fget(mget(lvl.x+flr(gx/8)+1,lvl.y+flr(gy/8)),0) then
		player.x = gx
		player.y = gy
	end
	
	oldx = btn(❎)
end

-->8
--util
function len(ax,ay,bx,by)
	local dx = ax-bx
	local dy = ay-by
	return sqrt(dx*dx+dy*dy),atan2(dy,dx)
end
-->8
--kas
kas = {}
function kas.init()
	lvl = {}
	lvl.x = 18
	lvl.y = 0
	lvl.w = 8
	lvl.h = 10
	room = 2
	player.x = 8
	player.y = 8*8
	set_cam()
end

function kas.update()
	game.update()
end

function kas.draw()
	game.draw()
end
-->8
--kamer
kamer = {}
function kamer.init()
	lvl = {}
	lvl.x = 26
	lvl.y = 3
	lvl.w = 6
	lvl.h = 7
	room = 1
	player.x = 4*8
	player.y = 5*8
	set_cam()
end

function kamer.update()
	game.update()
end

function kamer.draw()
	game.draw()
end
__gfx__
000000009999999961cccccc61c0000046566644444444444444444417700000000000007ddd7ddd7ddd7ddd0660000000088800066666666666666666666660
000000005cccc2e261cccccc61c000006456664655444444544444441dd00000111101117ddd7ddd7ddd7ddd6dd60000008cfc80611111111111111111111115
007007005cccb2e261cccccc61c000004455555544444444444444441dd00000111101117ddd7ddd7ddd7ddd6dd60000008fff80611111111111111111111115
000770005ccb42e261cccccc61c000006656665644444444444444441dd00000111101117ddd7ddd7ddd7ddd055d600000086800611111111111111111111115
00077000533c42e261cccccc61c0000066566656444444444444544417700000000000007ddd7ddd7ddd7ddd0005d60000066600611111111111111111111115
007007005bb332e261cccccc61c000004646665644444454444444441dd00000011111117ddd7ddd7ddd7ddd00005d6000f060f0611111111111111111111115
00000000533b322261111111611000004545554444444454444444441dd00000011111117ddd7ddd7ddd7ddd000005d6000ddd00611111111111111111111115
000000005555555566666666666000006656665444454444444444441dd0000001111111111111117ddd7ddd0000005d000f0f00611111111111111111111115
00000000000000000000600000000000055500600077770005555550000555505555555500400400555550000000000000000000611111111111111111111115
05555555066000000006060000000000500600700766667056666660005677755667666500444400464455000000000000000000611111111111111111111115
05775775606000000005550000000000006660707577776755557770005666655555555500414140464445500000000000000000611111111111111111111115
05765765000000000005550000000000600000705575756756665560005666655667666500444440444444500000000000000000611111111111111111111115
05655565677776000000000077000000560000705575756756776560005555555555555500044000444444500000000000000000611111111111111111111115
05665665067760000500050066576666600000707577576756666560056767505667666500444400444445500000000000000000611111111111111111111115
05555555005000007566657055557666000000700566567005566560567675005555555500444400444455000000000000000000611111111111111111111115
00500005550000000500050050007765677776000577570000055560555550000500000504444440555550000000000000000000611111111111111111111115
09999999000000000000600000000000055500600077770004444440000555500000000000000000000000000000000000111100611111111111111111111115
09ff9ff9066000000006060000000000500600a00766667046666660005c66650000000000000000000000000000000005155150611111111111111111111115
09f49f49606000000008880000000000006660a0757bbb6744447770005c11150000000000000000000000000000666005555550611111111111111111111115
0949994900000000000888000000000000c000a0557575674eee4460005c111500000000000d5d00000000006606000607633760611111111111111111111115
094494497cccc7000000000077000000000000a0554545674e77e460005555550000000000d5d5d0000ee000c666666607676360611111111111111111111115
09999999076670000d000d00665788885000c0a0754457674eeee460056161500000000000d5ddd000e00e000066666507376760611111111111111111111115
00900009005000007d666d705555788800c000a005665670044ee460561615000000000040dd55505e0000ee0006666505633750611111111111111111111115
00000000550000000d000d0050000785677776000577570000044460555550000000000044444440000000000000555000555500055555555555555555555550
00000000000000000000b000000070000000bb000008800000007000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000b0b000007a700000bbe000008e8000070a070000000c0000aa000020e0200070707000000330000000000000000000000000000000000
000000000000b000000b0a000000700000bb0e00000b8e00000aaa000c00c0c700a99a00002e20000033300033038b0000000000000000000000000000000000
00000000000b0000003b0000003bb00000eb0700003b00000000b00007c0c0b00090b900002e2020073b30700b330b80070a0700000000000000000000000000
000b0000003b000000bb3000000b3000007b3000000b30000033b33000b0b7b0000b3000000200e2003bb3000003000000777000000050000000000000000000
500b3005500b0005500b0005500b0005500b0005500b00055300300550bb00b5500b0005500b0b05573bb375500300055033330550b050000000000000000000
5444444554444445544444455444444554444445544444455444444554444445544444455444444554444445544444455cc3ccc5b0bb00350000000000000000
05555550055555500555555005555550055555500555555005555550055555500555555005555550055555500555555005555550b00b00030000000000000000
00000000000550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000050000000000000050a0000000000000000000000000880000000000000000000000000000000000000000000000000000000000000000000000000
00000000554400000000000050000000000000000000000000000888000000000000000000000000000000000000000000000000000000000000000000000000
000000000504400000000a0054444400000000000000000000000084400000000000090000440000000000000000000000000000000000000000000000000000
00000000000044000000000550000400000000000000000000000000444000000080000044400000000000000000000000000000000000000000000000000000
00000009900000000000a009900a0000000000000000000000055000004400000005508440000000000000000000000000000000000000000000000000000000
000000a99a000000000000a99a000000000000000000000000005500000000000090588800000000000000000000000000000000000000000000000000000000
00000aa99aa0000000000aa99aa00000000000000000000000005666000000000000588608000000000000000000000000000000000000000000000000000000
00000a9999a000000000000000000000000000000000000000006699999000000000000000000000000000000000000000000000000000000000000000000000
0000aaaaaaaa0000000000000000000000000000000000000000699fff9000000000000000000000000000000000000000000000000000000000000000000000
00000ffffff0000000000000000000000000000000000000000009fdfd9000000000000000000000000000000000000000000000000000000000000000000000
00000ff55ff0000000000000000000000000000000000000000009ffff9000000000000000000000000000000000000000000000000000000000000000000000
000000ffff00000000000000000000000000000000000000000009ffff9000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05555550055555500555555005555550055555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
56666665566cc6655aaaaaa55cc77cc5566666650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
56666665567ccc655aaa9aa55cc77cc5566666650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5666666556cccc655aa9aaa557777775566666650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
566666655cccccc55a9999a557777775566666650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
566666655cccccc55aaa9aa55cc77cc5566666650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5666666556cccc655aa9aaa55cc77cc5566666650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05555550055555500555555005555550055555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10101000100ee0220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010100010e00e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1110101010e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010e00e020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10100101000ee0220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000e0200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000555dd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00555ddddd5500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000dddddddc655000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000dddd5dd6c6c550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000dddddddc6c6c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000dd55ddd6c6c600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000dd55ddd6666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000066606660660066600000666060600000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000066606060606060000000606060600000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000060606660606066000000660066600000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000060606060606060000000606000600000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000060606060666066600000666066600000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000060606660666066606660606006600000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000060606060606066606060606060000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000066006600666060606660606066600000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000060606060606060606000606000600000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000060606060606060606000066066000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000006600000006606660666066000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000006600000060000600606060600000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000006600000066600600666060600000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000006060000000600600606060600000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000006660000066000600606060600000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000055000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000880000000000000000000500000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000888000000000000000055440000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000084400000000000000005044000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000444000000000000000004400000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000055000004400000000000990000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000550000000000000000a99a000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000056660000000000000aa99aa00000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000066999990000000000a9999a00000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000699fff9000000000aaaaaaaa0000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000009fdfd90000000000ffffff00000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000009ffff90000000000ff55ff00000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000009ffff900000000000ffff000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

__gff__
0000000001010100010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a00000202020202020203000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a13000202020202020203000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0909090909090909090909090909090900000202020202020203000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
08080808080808080808080808080808170006060605060605030a0a0a0a0a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0808080808080808080808080808080823000504040404040603090909090900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0808080808080808080808080808080800000605060406060603080808080807000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0808080808080808080808080808080827000605050405060603080808080807000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0808080808080808080808080808080800000605060406050603080808080807000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0808080808080808080808080808080800000404040404050503080808080808000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0808080808080808080808080808080800000505050505050503080808080807000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0808080808080808080808080808080800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0d0e0e0e0e0e0e0e0e0e0e0e0e0e0e0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1e1e1e1e1e1e1e1e1e1e1e1e1e1e1f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1e1e1e1e1e1e1e1e1e1e1e1e1e1e1f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1d1e1e1e1e1e1e1e1e1e1e1e1e1e1e1f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2d2e2e2e2e2e2e2e2e2e2e2e2e2e2e2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
010400000bb500bb500bb500bb500bb5014b5016b5017b5019b5019b5018b5017b500ab500ab500ab500ab5018b501db5021b5023b5024b5024b5024b5020b501fb5009b5009b5009b5009b5009b5009b5009b50
__music__
00 00424344

