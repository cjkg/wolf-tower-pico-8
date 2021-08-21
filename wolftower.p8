pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
--wolf tower
--by christopher gibilisco
 
--[[credits:



thanks to krystian majewski (krystman) of 
lazydevs for some of the basic functions used in 
this game, from his pico-8 tutorial here: 
https://www.youtube.com/watch?v=hny7inp74dw

in particular, i thank him for code in getframe(), 
_drawspr(), dofloats(), addfloat(), moveplayer(), 
the button loop in updategame(),
the juicy sine wave button animation for dialogue 
windows (which i added to the dtb), the fade funcs,
 
the json parser program was designed by tylerneylon, 
adapted by feneric, which tylerneylon has released 
into the public domain. feneric's adaptation of it is 
released under the gpl v3 license: 
https://www.gnu.org/licenses/gpl-3.0.en.html.
 
the dialogue text box library (dtb) was designed by 
oli414 under the cc by-nc-sa 4.0 license (see below 
for a link), and it frankly rules. thank you, oli414! 
here is the original post on the pico-8 bbs: 
https://www.lexaloffle.com/bbs/?tid=28465
 
this game is released under the cc by-nc-sa 4.0 license: 
https://creativecommons.org/licenses/by-nc-sa/4.0/
 
 
]]

function _init()
	t,tani,fadeperc=0,0,0
	_g=json_parse('{"levels":{"1":{"objects":[{"name":"cup","x":8,"y":9,"tiles":[20],"effects":[{"x":8,"y":9,"new_tile":63},{"x":8,"y":11,"new_tile":63},{"x":8,"y":5,"new_tile":64}],"dialog":"you drink the cup to the dregs. your sword crumbles into dust. you must rely on your wits alone.","float":[{"x":8,"y":9,"txt":"gulp!","c":11}],"sfx":1},{"name":"skeleton 1","x":8,"y":11,"tiles":[64,65],"effects":[],"dialog":"drink the cup to enter. the lord of the tower plays for keeps.","sfx":-1},{"name":"skeleton 2","x":8,"y":5,"tiles":[64,65],"effects":[],"dialog":"good luck, mortal.","sfx":-1}]},"2":{"objects":[{"name":"bad red","x":5,"y":13,"tiles":[53],"effects":[{"x":9,"y":13,"new_tile":51},{"x":7,"y":10,"new_tile":54}],"sfx":4},{"name":"bad green","x":9,"y":13,"tiles":[55],"effects":[{"x":5,"y":13,"new_tile":53},{"x":9,"y":13,"new_tile":51},{"x":7,"y":10,"new_tile":54}],"sfx":4},{"name":"bad blue","x":7,"y":10,"tiles":[54],"effects":[{"x":5,"y":13,"new_tile":53},{"x":9,"y":13,"new_tile":51},{"x":7,"y":10,"new_tile":54}],"sfx":4},{"name":"good green","x":9,"y":13,"tiles":[51],"effects":[{"x":5,"y":13,"new_tile":49},{"x":9,"y":13,"new_tile":55},{"x":7,"y":10,"new_tile":54}],"sfx":5},{"name":"good red","x":5,"y":13,"tiles":[49],"effects":[{"x":5,"y":13,"new_tile":53},{"x":9,"y":13,"new_tile":55},{"x":7,"y":10,"new_tile":50}],"sfx":6},{"name":"good blue","x":7,"y":10,"tiles":[50],"effects":[{"x":5,"y":13,"new_tile":63},{"x":9,"y":13,"new_tile":63},{"x":7,"y":10,"new_tile":63},{"x":7,"y":12,"new_tile":33}],"sfx":7},{"name":"red key","x":7,"y":12,"tiles":[33],"effects":[{"x":11,"y":12,"new_tile":2},{"x":7,"y":12,"new_tile":63}],"float":[{"x":11,"y":12,"txt":"!","c":8}],"sfx":13},{"name":"pinkie","x":13,"y":4,"tiles":[86,87],"dialog":"here to rescue those villagers? i saw them carried up a while ago. they won`t come back.","effects":[],"sfx":-1},{"name":"skelly","x":11,"y":3,"tiles":[76,77],"dialog":"yeah, adventurers always think they can stop our lord. what makes you so special?","effects":[],"sfx":-1},{"name":"ratso","x":8,"y":5,"tiles":[82,83],"dialog":"please don`t break any pots. we have to clean those up.","effects":[],"sfx":-1},{"name":"grayzo","x":3,"y":3,"tiles":[68,69],"dialog":"that first puzzle is just to keep out people who aren`t serious.","effects":[],"sfx":-1}]},"3":{"objects":[{"name":"golem","x":3,"y":11,"tiles":[72,73],"effects":[],"dialog":"it`s a pretty weird job, honestly. when our dread lord summoned me, i thought i`d be doing guard duty, but he mostly just makes us reset the puzzles.","sfx":-1},{"name":"ratso","x":2,"y":2,"tiles":[66,67],"effects":[],"dialog":"if two sentences contradict each other, one is true and one is false.","sfx":-1},{"name":"skelly","x":5,"y":4,"tiles":[92,93],"effects":[],"dialog":"guess wrong at a puzzle and the lord of the tower will kill a villager.","sfx":-1},{"name":"skeleton1","x":8,"y":3,"tiles":[80,81],"effects":[],"dialog":"one of these demons speaks truly, while the other two lie. but you can reason out the answer.","sfx":-1},{"name":"clue1","x":13,"y":2,"tiles":[84,85],"effects":[],"dialog":"the key is in chest 1.","sfx":-1},{"name":"clue2","x":9,"y":5,"tiles":[74,75],"effects":[],"dialog":"the key is not in chest 2.","sfx":-1},{"name":"clue3","x":13,"y":5,"tiles":[86,87],"effects":[],"dialog":"the key is not in chest 1.","sfx":-1},{"name":"chest1","x":9,"y":11,"tiles":[60],"effects":[{"x":9,"y":11,"new_tile":15},{"x":11,"y":11,"new_tile":32},{"x":13,"y":11,"new_tile":63}],"sfx":4},{"name":"chest2","x":11,"y":11,"tiles":[61],"effects":[{"x":9,"y":11,"new_tile":63},{"x":11,"y":11,"new_tile":32},{"x":13,"y":11,"new_tile":63}],"sfx":5},{"name":"chest3","x":13,"y":11,"tiles":[62],"effects":[{"x":9,"y":11,"new_tile":63},{"x":11,"y":11,"new_tile":32},{"x":13,"y":11,"new_tile":15}],"sfx":4},{"name":"key","x":11,"y":11,"tiles":[32],"effects":[{"x":7,"y":8,"new_tile":2},{"x":11,"y":11,"new_tile":63}],"float":[{"x":7,"y":8,"txt":"!","c":14}],"sfx":13},{"name":"body","x":9,"y":11,"tiles":[15],"effects":[],"dialog":"*dead silence*","sfx":-1},{"name":"body","x":13,"y":11,"tiles":[15],"effects":[],"dialog":"*dead silence*","sfx":-1}]},"4":{"objects":[{"name":"pinkie","x":4,"y":2,"tiles":[70,71],"float":[{"x":4,"y":2,"txt":"hiccup!","c":10}],"effects":[],"dialog":"have a drink!","sfx":-1},{"name":"greyzo","x":6,"y":2,"tiles":[84,85],"effects":[],"dialog":"those knight and knave demons drive me crazy. knights always tell the truth, but knaves always lie. i wish i could tell them apart.","sfx":-1},{"name":"greenie","x":10,"y":3,"tiles":[90,91],"effects":[],"dialog":"i`m free now, but we rotate in and out.","sfx":-1},{"name":"barkeep","x":13,"y":3,"tiles":[46],"effects":[],"dialog":"this stuff will kill ya, kid.","sfx":-1},{"name":"skeleton1","x":12,"y":7,"tiles":[80,81],"effects":[],"dialog":"these demons are knights and knaves. knights always tell the truth, and knaves always lie. there`s no way to tell them apart by looking at them, but you can reason out which chest to choose from their statements.","sfx":-1},{"name":"clue 1","x":9,"y":10,"tiles":[66,67],"effects":[],"dialog":"we are both knaves. the key is in chest 2.","sfx":-1},{"name":"clue 2","x":13,"y":12,"tiles":[86,87],"effects":[],"dialog":"i am a knight. the key is in chest 1.","sfx":-1},{"name":"chest1","x":3,"y":9,"tiles":[60],"effects":[{"x":3,"y":9,"new_tile":33},{"x":3,"y":13,"new_tile":63}],"sfx":5},{"name":"chest2","x":3,"y":13,"tiles":[61],"effects":[{"x":3,"y":13,"new_tile":15},{"x":3,"y":9,"new_tile":33}],"sfx":4},{"name":"key","x":3,"y":9,"tiles":[33],"effects":[{"x":10,"y":6,"new_tile":2},{"x":3,"y":9,"new_tile":63}],"float":[{"x":10,"y":6,"txt":"!","c":8}],"sfx":13},{"name":"body","x":3,"y":13,"tiles":[15],"effects":[],"dialog":"*dead silence*","sfx":-1}]},"5":{"objects":[{"name":"pinkie","x":3,"y":9,"tiles":[70,71],"effects":[],"dialog":"mr. fields is such a hardass. i don`t want to go back, but breaks over in 5 minutes.","sfx":-1},{"name":"greenie","x":4,"y":9,"tiles":[90,91],"effects":[],"dialog":"he acts like we`re so stupid. i can set up a damn puzzle -- i`m 3 million years old! i was a freaking prince in the 479th hell before i got summoned to this dump.","sfx":-1},{"name":"mr. fields","x":13,"y":9,"tiles":[84,85],"effects":[],"dialog":"hello, my name is mr. fields. this is our training center where we onboard new demons.","sfx":-1},{"name":"set up clue","x":2,"y":3,"tiles":[80,81],"effects":[],"dialog":"set up clue","sfx":-1},{"name":"clue 1","x":4,"y":2,"tiles":[66,67],"effects":[],"dialog":"clue 1","sfx":-1},{"name":"clue2","x":5,"y":4,"tiles":[92,93],"effects":[],"dialog":"clue2","sfx":-1},{"name":"chest1","x":9,"y":4,"tiles":[60],"effects":[{"x":9,"y":4,"new_tile":34},{"x":11,"y":4,"new_tile":63},{"x":13,"y":4,"new_tile":63}],"sfx":5},{"name":"chest2","x":11,"y":4,"tiles":[61],"effects":[{"x":9,"y":4,"new_tile":34},{"x":11,"y":4,"new_tile":15},{"x":13,"y":4,"new_tile":63}],"sfx":4},{"name":"chest3","x":13,"y":4,"tiles":[62],"effects":[{"x":9,"y":4,"new_tile":34},{"x":11,"y":4,"new_tile":63},{"x":13,"y":4,"new_tile":15}],"sfx":4},{"name":"key","x":9,"y":4,"tiles":[34],"effects":[{"x":7,"y":6,"new_tile":2},{"x":9,"y":4,"new_tile":63}],"float":[{"x":7,"y":5,"txt":"!","c":12}],"sfx":13},{"name":"body","x":11,"y":4,"tiles":[15],"effects":[],"dialog":"*dead silence*","sfx":-1},{"name":"body","x":13,"y":4,"tiles":[15],"effects":[],"dialog":"*dead silence*","sfx":-1}]},"6":{"objects":[{"name":"pinkie","x":2,"y":4,"tiles":[102,103],"effects":[],"dialog":"i am going to get so jacked. that will show them.","sfx":-1},{"name":"greenie","x":9,"y":5,"tiles":[106,107],"effects":[],"dialog":"an adventurer shows up and i`m just supposed to hold it until they leave? what`s with bosses and bathroom breaks?","sfx":-1},{"name":"skelly","x":10,"y":5,"tiles":[108,109],"effects":[],"dialog":"we need a union.","sfx":-1},{"name":"set up clue","x":7,"y":9,"tiles":[80,81],"effects":[],"dialog":"set up clue","sfx":-1},{"name":"clue 1","x":5,"y":11,"tiles":[68,69],"effects":[],"dialog":"clue 1","sfx":-1},{"name":"clue2","x":6,"y":13,"tiles":[66,67],"effects":[],"dialog":"clue2","sfx":-1},{"name":"clue3","x":8,"y":12,"tiles":[88,89],"effects":[],"dialog":"clue3","sfx":-1},{"name":"chest1","x":13,"y":9,"tiles":[60],"effects":[{"x":13,"y":9,"new_tile":15},{"x":13,"y":11,"new_tile":63},{"x":13,"y":13,"new_tile":35}],"sfx":4},{"name":"chest2","x":13,"y":11,"tiles":[61],"effects":[{"x":13,"y":9,"new_tile":63},{"x":13,"y":11,"new_tile":15},{"x":13,"y":13,"new_tile":35}],"sfx":4},{"name":"chest3","x":13,"y":13,"tiles":[62],"effects":[{"x":13,"y":9,"new_tile":63},{"x":13,"y":11,"new_tile":63},{"x":13,"y":13,"new_tile":35}],"sfx":4},{"name":"key","x":13,"y":13,"tiles":[35],"effects":[{"x":2,"y":14,"new_tile":2},{"x":13,"y":13,"new_tile":63}],"float":[{"x":2,"y":14,"txt":"!","c":3}],"sfx":13},{"name":"body","x":13,"y":9,"tiles":[15],"effects":[],"dialog":"*dead silence*","sfx":-1},{"name":"body","x":13,"y":11,"tiles":[15],"effects":[],"dialog":"*dead silence*","sfx":-1}]},"7":{"objects":[{"name":"pinkie","x":9,"y":5,"tiles":[86,87],"effects":[],"dialog":"this is where we do our r&d into puzzles.","sfx":-1},{"name":"grayzo","x":10,"y":2,"tiles":[68,69],"effects":[],"dialog":"things are coming along nicely. we`ll meet our deadline.","sfx":-1},{"name":"ratso","x":8,"y":2,"tiles":[82,83],"effects":[],"dialog":"our research hasn`t really been fruitful. but we tell our dread lord it is.","sfx":-1},{"name":"set up clue","x":6,"y":11,"tiles":[80,81],"effects":[],"dialog":"set up clue","sfx":-1},{"name":"clue 1","x":4,"y":11,"tiles":[74,75],"effects":[],"dialog":"clue 1","sfx":-1},{"name":"clue2","x":3,"y":13,"tiles":[72,73],"effects":[],"dialog":"clue2","sfx":-1},{"name":"clue3","x":7,"y":13,"tiles":[92,93],"effects":[],"dialog":"clue3","sfx":-1},{"name":"chest1","x":10,"y":13,"tiles":[60],"effects":[{"x":10,"y":13,"new_tile":15},{"x":12,"y":13,"new_tile":32},{"x":14,"y":13,"new_tile":63}],"sfx":4},{"name":"chest2","x":12,"y":13,"tiles":[61],"effects":[{"x":10,"y":13,"new_tile":63},{"x":12,"y":13,"new_tile":32},{"x":14,"y":13,"new_tile":63}],"sfx":5},{"name":"chest3","x":14,"y":13,"tiles":[62],"effects":[{"x":10,"y":13,"new_tile":63},{"x":12,"y":13,"new_tile":32},{"x":14,"y":13,"new_tile":15}],"sfx":4},{"name":"key","x":12,"y":13,"tiles":[32],"effects":[{"x":4,"y":8,"new_tile":2},{"x":12,"y":13,"new_tile":63}],"float":[{"x":4,"y":8,"txt":"!","c":14}],"sfx":13},{"name":"body","x":10,"y":13,"tiles":[15],"effects":[],"dialog":"*dead silence*","sfx":-1},{"name":"body","x":14,"y":13,"tiles":[15],"effects":[],"dialog":"*dead silence*","sfx":-1},{"name":"computer1.1","x":11,"y":6,"tiles":[96,97],"effects":[],"float":[{"x":11,"y":6,"txt":"beep!","c":8}],"sfx":14},{"name":"computer1.2","x":11,"y":7,"tiles":[112,113],"effects":[],"float":[{"x":11,"y":6,"txt":"beep!","c":8}],"sfx":14},{"name":"computer2.1","x":12,"y":6,"tiles":[96,97],"effects":[],"float":[{"x":12,"y":6,"txt":"beep!","c":10}],"sfx":14},{"name":"computer2.2","x":12,"y":7,"tiles":[112,113],"effects":[],"float":[{"x":12,"y":6,"txt":"beep!","c":10}],"sfx":14},{"name":"computer3.1","x":13,"y":6,"tiles":[96,97],"effects":[],"float":[{"x":13,"y":6,"txt":"beep!","c":11}],"sfx":14},{"name":"computer3.2","x":13,"y":7,"tiles":[112,113],"effects":[],"float":[{"x":13,"y":6,"txt":"beep!","c":11}],"sfx":14},{"name":"ladder1.1","x":7,"y":1,"tiles":[98,99],"effects":[],"float":[{"x":7,"y":1,"txt":"zap!","c":10}],"sfx":15},{"name":"ladder1.2","x":7,"y":2,"tiles":[114,115],"effects":[],"float":[{"x":7,"y":1,"txt":"zap!","c":10}],"sfx":15},{"name":"ladder2.1","x":7,"y":6,"tiles":[98,99],"effects":[],"float":[{"x":7,"y":6,"txt":"zap!","c":10}],"sfx":15},{"name":"ladder2.2","x":7,"y":7,"tiles":[114,115],"effects":[],"float":[{"x":7,"y":6,"txt":"zap!","c":10}],"sfx":15}]},"8":{"objects":[{"name":"wolf","x":7,"y":11,"tiles":[240],"effects":[],"dialog":"one of these cups is poison, the others are wine. you choose my cup, then i`ll choose thine. speak to my servants for the clue, but you`ll die before i do.","sfx":-1},{"name":"wolf","x":8,"y":11,"tiles":[241],"effects":[],"dialog":"one of these cups is poison, the others are wine. you choose my cup, then i`ll choose thine. speak to my servant for the clue, but you`ll die before i do","sfx":-1},{"name":"pinkie","x":5,"y":6,"tiles":[70,71],"effects":[],"dialog":"clue 1","sfx":-1},{"name":"skelly","x":7,"y":4,"tiles":[76,77],"effects":[],"dialog":"clue 2","sfx":-1},{"name":"greenie","x":10,"y":6,"tiles":[90,91],"effects":[],"dialog":"clue 3","sfx":-1},{"name":"cup1","x":5,"y":2,"tiles":[16],"effects":[{"x":5,"y":2,"new_tile":63},{"x":8,"y":2,"new_tile":63},{"x":11,"y":2,"new_tile":63},{"x":10,"y":10,"new_tile":23},{"x":7,"y":9,"new_tile":217},{"x":8,"y":9,"new_tile":218},{"x":7,"y":10,"new_tile":233},{"x":8,"y":10,"new_tile":234},{"x":7,"y":11,"new_tile":249},{"x":8,"y":11,"new_tile":250},{"x":4,"y":8,"new_tile":63},{"x":5,"y":6,"new_tile":63},{"x":10,"y":6,"new_tile":63},{"x":7,"y":4,"new_tile":63}],"dialog":"the first cup it is. you shall drink the third cup. come to the table and take your drink.","sfx":-1},{"name":"cup2","x":8,"y":2,"tiles":[17],"effects":[{"x":5,"y":2,"new_tile":63},{"x":8,"y":2,"new_tile":63},{"x":11,"y":2,"new_tile":63},{"x":10,"y":10,"new_tile":23},{"x":7,"y":9,"new_tile":217},{"x":8,"y":9,"new_tile":218},{"x":7,"y":10,"new_tile":233},{"x":8,"y":10,"new_tile":234},{"x":7,"y":11,"new_tile":249},{"x":8,"y":11,"new_tile":250}],"dialog":"the second cup it is. you shall drink the third cup. come to the table and take your drink.","sfx":-1},{"name":"cup3","x":11,"y":2,"tiles":[18],"effects":[{"x":5,"y":2,"new_tile":63},{"x":8,"y":2,"new_tile":63},{"x":11,"y":2,"new_tile":63},{"x":10,"y":10,"new_tile":22},{"x":7,"y":9,"new_tile":217},{"x":8,"y":9,"new_tile":218},{"x":7,"y":10,"new_tile":233},{"x":8,"y":10,"new_tile":234},{"x":7,"y":11,"new_tile":249},{"x":8,"y":11,"new_tile":250}],"dialog":"the third cup it is. you shall drink the first cup. come to the table and take your drink.","sfx":-1},{"name":"killercup","x":10,"y":10,"tiles":[23],"float":[{"x":10,"y":10,"txt":"gulp!","c":8},{"x":7,"y":8,"txt":"gulp!","c":8}],"effects":[{"x":10,"y":10,"new_tile":63}],"sfx":-1,"win":"no"},{"name":"winnercup","x":10,"y":10,"tiles":[22],"float":[{"x":10,"y":10,"txt":"gulp!","c":8},{"x":7,"y":8,"txt":"gulp!","c":8}],"effects":[{"x":7,"y":8,"new_tile":63},{"x":8,"y":8,"new_tile":63},{"x":7,"y":9,"new_tile":63},{"x":8,"y":9,"new_tile":63},{"x":7,"y":10,"new_tile":227},{"x":8,"y":10,"new_tile":228},{"x":7,"y":11,"new_tile":243},{"x":8,"y":11,"new_tile":244},{"x":10,"y":10,"new_tile":63},{"x":9,"y":11,"new_tile":245},{"x":6,"y":11,"new_tile":242},{"x":5,"y":9,"new_tile":33},{"x":4,"y":8,"new_tile":63},{"x":5,"y":6,"new_tile":63},{"x":10,"y":6,"new_tile":63},{"x":7,"y":4,"new_tile":63}],"sfx":-1,"win":"yes"},{"name":"wolf2left","x":7,"y":11,"tiles":[249],"effects":[],"dialog":"are you afraid to die? i`m not.","sfx":-1},{"name":"wolf2right","x":8,"y":11,"tiles":[250],"effects":[],"dialog":"are you afraid to die? i`m not.","sfx":-1},{"name":"skelly","x":4,"y":8,"tiles":[64,65],"effects":[],"dialog":"clue setup.","sfx":-1},{"name":"red key","x":5,"y":9,"tiles":[33],"effects":[{"x":3,"y":5,"new_tile":63},{"x":5,"y":9,"new_tile":63}],"float":[{"x":3,"y":5,"txt":"!","c":8}],"sfx":13}]},"9":{"objects":[]}},"mapani":{"ani1":[6,8,64,66,68,70,72,74,76,80,82,84,86,88,90,92,96,98,100,102,106,108,116,78,94,118,120,122,124],"ani2":[7,9,65,67,69,71,73,75,77,81,83,85,87,89,91,93,97,99,101,103,107,109,117,79,95,119,121,123,125]},"dpal":[0,1,1,2,1,13,6,4,4,9,3,13,1,13,14],"dirx":[-1,1,0,0,1,1,-1,-1],"diry":[0,0,-1,1,-1,1,1,-1],"p_ani":[126,126,127,127]}')

	--★
	debug={}

	dtb_init()
	startgame()
end

function _update60()
	t+=1
	
	dtb_update()
	dofloats()
	
	_upd()
end

function _draw()
	_drw()
	checkfade()

	--★
	cursor(4,4)
	color(8)
	for txt in all(debug) do
		print(txt)
	end
	
end

function startgame()	
	p_x,p_y,p_t,p_flip=8,13,0,false
	_upd=update_game
	_drw=draw_game
	dpal,dirx,diry,p_ani,mapani=_g.dpal,_g.dirx,_g.diry,_g.p_ani,_g.mapani
	villagers=6
	float={}
	genlevel(1)
end
-->8
--updates

function update_game()
	for i=0,3 do
		if btn(i) and #dtb_queu==0 then
			moveplayer(dirx[i+1],diry[i+1])			
			return
		end
	end
end

function update_pturn()
	p_t=min(p_t+0.125,1) --desensitizes
	
	if p_t==1 then
		_upd=update_game
		step()
	end
end

function update_gameover()
	if btnp(❎) then
		fadeout()
		startgame()
	end
end

function update_win()
	p_x=7
	p_y=11
	if btnp(❎) then
		fadeout()
		startgame()
	end
end
-->8
--draws

function draw_game()
	if fadeperc==1 then return end --fixes flicker

	animap()

	cls()
	map()
	
	_drawspr(getframe(p_ani),p_x*8,p_y*8,10,p_flip)
	dtb_draw()
	
	for f in all(float) do
		oprint8(f.txt,f.x,f.y,f.c,0)
	end
end

function draw_win()
	cls()
	map()
	
	copymap(16,16)
	
	print("villagers saved: "..tostr(villagers),26,100)
	
	print("press ❎",46,114,5+abs(sin(time()/3)*2))
end

function draw_gameover()
	cls()
	map()
	copymap(16,16)
	mset(7,7,162)
	mset(8,7,163)
	print("you died",46,100)

	print("press ❎",46,114,5+abs(sin(time()/3)*2))

end

function animap()
	tani+=1
	if (tani<30) return
	tani=0
	for x=0,15 do
		for y=0,15 do
			local tle=mget(x,y)
			if isin(tle,mapani.ani1) then
				tle+=1
			elseif isin(tle,mapani.ani2) then
				tle-=1
			end
		mset(x,y,tle)
		end
	end
end
-->8
--tools

function getframe(ani)
	return ani[flr(t/8)%#ani+1]
end

function _drawspr(_spr,_x,_y,_c,_flip)
	palt(0,false)
	pal(6,_c)
	spr(_spr,_x,_y,1,1,_flip)
	pal()
end

function oprint8(_t,_x,_y,_c,_c2)
	for i=1,8 do
	  print(_t,_x+dirx[i],_y+diry[i],_c2)
	end
	print(_t,_x,_y,_c)
end


function isin(mem,set)
	for m in all(set) do
		if m==mem then
			return true
		end
	end
	return false
end

function dofade()
local p,kmax,col,k=flr(mid(0,fadeperc,1)*100)
 for j=1,15 do
  col = j
  kmax=flr((p+j*1.46)/22)
  for k=1,kmax do
   col=dpal[col]
  end
  pal(j,col,1)
 end
end

function checkfade()
 if fadeperc>0 then
  fadeperc=max(fadeperc-0.04,0)
  dofade()
 end
end

function wait(_wait)
 repeat
  _wait-=1
  flip()--?
 until _wait<0
end

function fadeout(spd,_wait)
	if (spd==nil) spd=0.04
 	if (_wait==nil) _wait=0
 	repeat
  	fadeperc=min(fadeperc+spd,1)
  	dofade()
 		flip()
 	until fadeperc==1
 	wait(_wait)
end

function copymap(x,y)
	local tle
	for _x=0,15 do
  	for _y=0,15 do
  		tle=mget(_x+x,_y+y)
   		mset(_x,_y,tle)
   		if tle==4 then
   			p_x,p_y=_x,_y
   		end
  	end
 	end
end

-- json parser
-- from: https://gist.github.com/tylerneylon/59f4bcf316be525b30ab
_tok={
 ['true']=true,
 ['false']=false}
_g={}

table_delims={['{']="}",['[']="]"}

function match(s,tokens)
  for i=1,#tokens do
		if(s==sub(tokens,i,i)) return true
  end
  return false
end

function skip_delim(wrkstr, pos, delim, err_if_missing)
 if sub(wrkstr,pos,pos)!=delim then
  return pos,false
 end
 return pos+1,true
end

function parse_str_val(wrkstr, pos, val)
  val=val or ''
  local c=sub(wrkstr,pos,pos)
  if(c=='"') return _g[val] or val,pos+1
  return parse_str_val(wrkstr,pos+1,val..c)
end

function parse_num_val(wrkstr,pos,val)
  val=val or ''
  local c=sub(wrkstr,pos,pos)
  if(not match(c,"-xb0123456789abcdef.")) return tonum(val),pos
  return parse_num_val(wrkstr,pos+1,val..c)
end

function json_parse(wrkstr, pos, end_delim)
 pos=pos or 1

 local first=sub(wrkstr,pos,pos)
 if match(first,"{[") then
		local obj,key,delim_found={},true,true
		pos+=1
		while true do
	 		key,pos=json_parse(wrkstr, pos, table_delims[first])
	 		if(key==nil) return obj,pos
	 		if first=="{" then
				pos=skip_delim(wrkstr,pos,':',true)  -- true -> error if missing.
				obj[key],pos=json_parse(wrkstr,pos)
		 	else
				add(obj,key)
	 		end
	 		pos,delim_found=skip_delim(wrkstr, pos, ',')
		end
	elseif first=='"' then
		return parse_str_val(wrkstr,pos+1)
	elseif match(first,"-0123456789") then
		return parse_num_val(wrkstr, pos)
	elseif first==end_delim then  -- end of an object or array.
		return nil,pos+1
	else
		for lit_str,lit_val in pairs(_tok) do
			local lit_end=pos+#lit_str-1
			if sub(wrkstr,pos,lit_end)==lit_str then return lit_val,lit_end+1 end
		end
	end
end

--below is the dtb, 
--credit to oli414!


-- call this before you start using dtb.
-- optional parameter is the number of lines that are displayed. default is 3.
function dtb_init(numlines)
    dtb_queu={}
    dtb_queuf={}
    dtb_numlines=3
    if numlines then
        dtb_numlines=numlines
    end
    _dtb_clean()
end

-- this will add a piece of text to the queu. the queu is processed automatically.
function dtb_disp(txt,callback)
    local lines={}
    local currline=""
    local curword=""
    local curchar=""
    local upt=function()
        if #curword+#currline>29 then
            add(lines,currline)
            currline=""
        end
        currline=currline..curword
        curword=""
    end
    for i=1,#txt do
        curchar=sub(txt,i,i)
        curword=curword..curchar
        if curchar==" " then
            upt()
        elseif #curword>28 then
            curword=curword.."-"
            upt()
        end
    end
    upt()
    if currline~="" then
        add(lines,currline)
    end
    add(dtb_queu,lines)
    if callback==nil then
        callback=0
    end
    add(dtb_queuf,callback)
end

-- functions with an underscore prefix are ment for internal use, don't worry about them.
function _dtb_clean()
    dtb_dislines={}
    for i=1,dtb_numlines do
        add(dtb_dislines,"")
    end
    dtb_curline=0
    dtb_ltime=0
end

function _dtb_nextline()
    dtb_curline+=1
    for i=1,#dtb_dislines-1 do
        dtb_dislines[i]=dtb_dislines[i+1]
    end
    dtb_dislines[#dtb_dislines]=""
    sfx(2)
end

function _dtb_nexttext()
    if dtb_queuf[1]~=0 then
        dtb_queuf[1]()
    end
    del(dtb_queuf,dtb_queuf[1])
    del(dtb_queu,dtb_queu[1])
    _dtb_clean()
    sfx(2)
end

-- make sure that this function is called each update.
function dtb_update()
    if #dtb_queu>0 then
        if dtb_curline==0 then
            dtb_curline=1
        end
        local dislineslength=#dtb_dislines
        local curlines=dtb_queu[1]
        local curlinelength=#dtb_dislines[dislineslength]
        local complete=curlinelength>=#curlines[dtb_curline]
        if complete and dtb_curline>=#curlines then
            if btnp(5) then
                _dtb_nexttext()
                return
            end
        elseif dtb_curline>0 then
            dtb_ltime-=1
            if not complete then
                if dtb_ltime<=0 then
                    local curchari=curlinelength+1
                    local curchar=sub(curlines[dtb_curline],curchari,curchari)
                    dtb_ltime=1
                    if curchar~=" " then
                        sfx(0)
                    end
                    if curchar=="." then
                        dtb_ltime=6
                    end
                    dtb_dislines[dislineslength]=dtb_dislines[dislineslength]..curchar
                end
                if btnp(5) then
                    dtb_dislines[dislineslength]=curlines[dtb_curline]
                end
            else
                if btnp(5) then
                    _dtb_nextline()
                end
            end
        end
    end
end

-- make sure to call this function everytime you draw.
function dtb_draw()
    if #dtb_queu>0 then
        local dislineslength=#dtb_dislines
        local offset=0
        if dtb_curline<dislineslength then
            offset=dislineslength-dtb_curline
        end
        rectfill(2,125-dislineslength*8,125,125,0)
        if dtb_curline>0 and #dtb_dislines[#dtb_dislines]==#dtb_queu[1][dtb_curline] then
            print("❎",118,120+min(sin(time())),7)
        end
        for i=1,dislineslength do
            print(dtb_dislines[i],4,i*8+119-(dislineslength+offset)*8,7)
        end
    end
end

-->8
--gameplay

function moveplayer(dx,dy)
	local destx,desty=p_x+dx,p_y+dy
	local tile=mget(destx,desty)
	p_t=0
	_upd=update_pturn
	
	if fget(tile,0) and not fget(tile,1) then
		--wall
			sfx(3)		
	elseif fget(tile,1) then
		bump(tile,destx,desty)
	else
		p_x+=dx
		p_y+=dy
		
		if dx<0 then
			p_flip=true
		elseif dx>0 then
			p_flip=false
		end
		sfx(0)
	end
end

function bump(tile,destx,desty)
	for obj in all(objects) do
		if obj.x==destx 
			and obj.y==desty 
			and isin(tile,obj.tiles) then
		
			sfx(obj.sfx)
			
			if obj.dialog then
				dtb_disp(obj.dialog)
			end
			
			local _float=obj.float
			if _float then
				for _f in all(_float) do
					addfloat(_f.txt,
						_f.x*8,
						_f.y*8,
						_f.c)
				end
			end
			
			for fx in all(obj.effects) do					
				mset(fx.x,fx.y,fx.new_tile)
			end
			
			if obj.win=="no" then
				--★
				--sfx(?)
				--death animation
				fadeout(.25)
				_upd=update_gameover
				_drw=draw_gameover
			end
						
			break
		end
	end
end

function step()
	if mget(p_x,p_y)==5 then
		genlevel(level+1)
		fadeout()
	end
	if mget(p_x,p_y)==27 then
		addfloat("hooray!",56,64,12)
	end
	if mget(p_x,p_y)==28 then
		fadeout()
		_upd=update_win
		_drw=draw_win
	end
end	
-->8
--ui

function addfloat(_txt,_x,_y,_c)
	_x=mid(0,_x-(#_txt*4)/2+5,128-(#_txt*4+4))
	add(float,{txt=_txt,x=_x,y=_y,c=_c,targety=_y-10,timer=40})
end

function dofloats()
	for f in all(float) do
		f.y+=(f.targety-f.y)/10
		f.timer+=1
		if f.timer>70 then
			del(float,f)
		end
	end
end
-->8
--map

function genlevel(l)
	level=l
	objects=_g.levels[tostr(level)].objects
	if level==2 then
		copymap(16,0)
	elseif level==3 then
		copymap(32,0)
	elseif level==4 then
		copymap(48,0)
	elseif level==5 then
		copymap(64,0)
	elseif level==6 then
		copymap(80,0)
	elseif level==7 then
		copymap(96,0)
	elseif level==8 then
	--	copymap(112,0)
	--elseif level==9 then
		copymap(0,16)
	elseif level==9 then
		copymap(32,16)
		if villagers>1 then
			mset(6,6,118)
		end
		if villagers>2 then
			mset(8,6,124)
		end
		if villagers>3 then
			mset(9,8,122)
		end
		if villagers>4 then
			mset(8,10,78)
		end
		if villagers>5 then
			mset(6,10,120)
		end
	end
end

__gfx__
000000001dd6ddd0dd0d0dd000ddd000dd0d0dd0dd0d0dd00b00000000000000000000b000000000000000ddddddddddd000000000aaa00000ddd00000777700
00000000d1ddddd0000000000dd0dd0066000000cc000000300000000b00000000000003000000b000000000000000000000000009000a000ddddd0007777770
007007001dddd6d0d0ddd0d0d0d0d0d0660660d0cc0cc0d03300000033000000000000330000003300000ddddddddddddd000000909990a0dd000dd007777770
000770001d1dddd000000000d0d0d0d066066060cc0cc0c0000000000000000000000000000000000000000000000000000000009a000aa0dd000dd006770700
000770001d111dd000000000d0d0d0d066066060cc0cc0c0660000006600000000000066000000660000ddddddddddddddd0000099aaaaa0ddd0ddd002667770
0070070011dddd1000000000d0d0d0d000066060000cc0c000000000000000000000000000000000000000000000000000000000099aa900dd000dd088227778
00000000111111d000000000ddddddd000000060000000c050000000500000000000000500000005000ddddddddddddddddd000000999000ddddddd008882228
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008880
0000000000000000000000000000000000000000444444440000000000000000022222222222222222222222dd0d0dd000000000000000000000600000060000
098878a0098878a0098878a0097878a0093b7ba004444440098e7ea0098e7ea022222222222222222222222000000000000000000000000000448400004c4400
098888a0098788a0098787a0098787a00933b3a0044004400988e8a00988e8a0022222222222222222222222d0ddd0d0000000000000000004448440044c4440
098888a0098888a0098888a0098888a0093333a004000040098888a0098888a02222222222222222222222200000000000000000000000000444444004444440
009aaa00009aaa00009aaa00009aaa00009aaa0004000040009aaa00009aaa000222222222222222222222220000000000000000000000000044440000444400
0009a0000009a0000009a0000009a0000009a000040000400009a0000009a0002222222222222222222222200000000000000000000000000005500000055000
00999a0000999a0000999a0000999a0000999a000400004000999a0000999a000222222222222222222222220000000000000000000000000055550000555500
00000000000000000000000000000000000000000000000044444444444444442222222222222222222222200000000000000000000000000000000000000000
00aaa00000aaa00000aaa00000aaa00000000000dd0d0880dd0d0dd0dd0d0dd00000000000000000444444445555555544444444000000004444442044446444
0aee7a000a887a000acc7a000a337a00000000000000000000000000000000000000000000044400444444445555555544444444222222224444442044448444
0aeeea000a888a000accca000a333a0000000000d0ddd0d0d0ddd0c030ddd0d00000000000444440444444445555555544444444444444444444442044648444
00aaa00000aaa00000aaa00000aaa000000000000000000000000000000000000000000000444440444444445555555544444464444444444444442044c48464
000a0000000a0000000a0000000a00000000000000000000000000000000000000000000000444004444444455555555444444b4444444444444442044c444b4
000a0000000a0000000a0000000a00000000000000000000000000000000000000000000000050004444444455555555444444b4444444444444442044c444b4
000aa000000aa000000aa000000aa0000000000000000000000000000000000000000000000060004444444455555555444444b44444444444444420444444b4
00000000000000000000000000000000000000000000000000000000000000000000000000000000222222220000000044444422444444444444442022222222
0000000082222220c11111c0311111300000000082222220c11111c031111130ddeeedd0dd888dd0ddcccdd0663336601ccccc101ccccc101ccccc1000000000
00000000288888201ccccc101333331000000000288888201ccccc10133333100eeeee00088888000ccccc000333330011c8c110118c811018c8c81000000000
00000000282228201c111c101311131000000000282228201c111c1013111310ee000ee088000880cc000cc0330003301ccccc101ccccc101ccccc1000000000
00000000282228201c111c101311131000000000282228201c111c1013111310ee000ee088000880cc000cc033000330000a0000000a0000000a000000000000
00000000282228201c111c101311131000000000282228201c111c1013111310eee0eee088808880ccc0ccc0333033301ccccc101ccccc101ccccc1000000000
00000000288888201ccccc101333331000000000288888201ccccc1013333310ee000ee088000880cc000cc0330003301ccccc101ccccc101ccccc1000000000
0000000082222280c1111110111111300000000082222280c111111011111130eeeeeee088888880ccccccc03333333011111110111111101111111000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000880000008800000a0a00000000000000660000006600000e0e00000e0e00000f00f0000f00f000b000b000b000b0000cccc00000000000022220000222200
0088880000888800000a0a0000a0a00000660600006606000eeeee000eeeee000ffffff00ffffff00bbbbb000bbbbb000cccccc000cccc000022222000222220
008080000080800000aaaaa0000a0a0000606000006060000ee0e0e00eeeeee000ffff0000ffff000bb0b0000b0b0b000cccccc00cccccc00002022000020220
00888800008888000aa0000000aaaaa000666600006666000ee0e0e00ee0e0e00ff0f0f00ff0f0f00bbbbb000bbbbb000ccc9c800cccccc00022222000222220
00000000000000000aa0a0a00aa000000660006006600060eeeeeee0eeeeeee00fff0ff00fff0ff0bbbbbbb0bbbbbbb000ccccc00ccc8c900222222202222222
0800008008000080000000000aa0a0a0006666000066660000eee00000eee00000ffff0000ffff000bbbbb000bbbbb000000ccc000ccccc00022222200222222
00080800008080000a00a000000a000000060600000060000e000e000e000e0000f00f000000f0000b000b000b000b00000000000000ccc00020002000020000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0008800000088000000a0a00000000000006600000066000000e0e00000e0e0000f00f0000f00f0000b000b000b000b000cccc000000000000dddd0000dddd00
008888000088880000a0a000000a0a00006066000060660000eeeee000eeeee00ffffff00ffffff000bbbbb000bbbbb00cccccc000cccc000ddddd000ddddd00
00080800000808000aaaaa0000a0a00000060600000606000e0e0ee00eeeeee000ffff0000ffff00000b0bb000b0b0b00cccccc00cccccc00dd0d0000dd0d000
008888000088880000000aa00aaaaa0000666600006666000e0e0ee00e0e0ee00f0f0ff00f0f0ff000bbbbb000bbbbb008c9ccc00cccccc00ddddd000ddddd00
00000000000000000a0a0aa000000aa006000660060006600eeeeeee0eeeeeee0ff0fff00ff0fff00bbbbbbb0bbbbbbb0ccccc0009c8ccc0ddddddd0ddddddd0
0800008008000080000000000a0a0aa00066660000666600000eee00000eee0000ffff0000ffff0000bbbbb000bbbbb00ccc00000ccccc00dddddd00dddddd00
0080800000080800000a00a00000a000006060000006000000e000e000e000e000f00f00000f000000b000b000b000b0000000000ccc00000d000d000000d000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555550555555500c0000c00c0a00c000dddd0000dddd0000e0e00000e0e00000999908004444000b000b000b000b0000cccc00000000000000000000000000
5666665056666650060000600600a0600dddddd0055dddd00aaaaa000aaaaa000999990400ffff400aaaaa000aaaaa000aaaaaa000cccc000000000000000000
5666665056666650666006666660066655555555555555550ee0e0e00eeeeee009909004000f0f440bb0b0000b0b0b000cccccc00aaaaaa09969999000000000
5b686a505a6b6850050a0050050a005006666660066666600ee0e0e00ee0e0e00999990400ffff440bbbbb000bbbbb0008c9ccc00cccccc09999990000000000
56666650566666506660a6666660a66606bbbb6006bbbb60eeeeeee0eeeeeee0999999940feeee4ebbbbbbb0bbbbbbb00ccccc0009c8ccc09969998000000000
5666665056666650050000500500005006b33b6006b3376000eee00000eee0009999990000eeeeef0bbbbb000bbbbb000ccc00000ccccc009999998800000000
5655565056555650666a06666660066606b3376006b37b600e000e000e000e0009000900000200000b000b000b000b00000000000ccc00002999999800000000
56666650566666500500a05005000050063373600633336000000000000000000000000000000000000000000000000000000000000000008222222000000000
56666650566666506660066666600666063333600633336000aaaa0000aaaa0000eeee0000eeee0000cccc0000cccc0000888800008888000099990800999909
5666665056666650060000600600006006333360063333600aaaaa000aaaaa000eeeee000eeeee0000ccccc000ccccc000888880008888800999990409999904
5655565056555650060000600600006006b33b6006b37b600aa0a0000aa0a0000ee0e0000ee0e000000c0cc0000c0cc000080880000808800990900409909004
5666665056666650006006000060060006b37b6006b73b600aaaaa000aaaaa000eeeee000eeeee0000ccccc000ccccc000888880008888800999990409999904
5655565056555650000660000006600006b73b6006b33b60aaaaaaa0aaaaaaa0eeeeeee0eeeeeee00ccccccc0ccccccc08888888088888889999999499999994
5666665056666650000660000006600006b33b6006b33b60aaaaaa00aaaaaa00eeeeee00eeeeee0000cccccc00cccccc00888888008888889999990099999900
5655565056555650044444400444444044444444444444440a000a000000a0000e000e000000e00000c000c0000c000000800080000800000900090000009000
56666650566666500555555005555550055555500555555000000000000000000000000000000000000000000000000000000000000000000000000000000000
090009009900900099990009999900990090009099990999000000000000000000000022222222222200000000b000b0ddbd0db0444444444444444444444440
09090909009090009000000009000900909090909000090090000000000000000000022888888888822000000003030000030300333333334333333333333340
09090909009090009000000009000900909090909000090090000000000000000000228222222222282200000b303300db3033d0366363334333333333333340
0909090900909000999000000900090090909090999009990000000000000000000022828888888828220000000330b0000330b0333333334333333333333340
09090909009090009000000009000900909090909000090090000000000000000000228288888888282200000003300000033000336666364333333333333340
09090909009090009000000009000900909090909000090090000000000000000000228222222222282200000004400000044000333333334333333333333340
00909000990099909000000009000099000909009999090090000000000000000000022888888888822000000004400000044000333333334333333333333340
00000000000000000000000000000000000000000000000000000000000000000000002222222222220000000000000000000000444444444444444444444440
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005550000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000d000000000000444444000000588885000000066655000000000000055555555000000000000
000000000000000000000000000000000000000000000000000d0000000000000444444000600088880006000666665500080080000056666665000000000000
00000000000000000000000000000000000000000000000000d00000000000000444444005600088880006506666666500088880000055555555000000000000
00000000000000000000000000000000000000000000000000d00000000000000444444005655555555556506660666500080080000505000050500000000000
000000000000000000000000000000000ffff00000000000000d000000000000008888000560008888000650666666650c00c000000505000050500000000000
00000000000000000000000000000000ffffff00000000000000ddd000000000000000000060008888000600066666000cccc000000505000050500000000000
0000000000000000000000000000000ffffffff0000000000000000d00000000000000000000008888000000006660000c00c0000005dddddddd500000000000
00000000000000000000d0d0d000000ffffffff00000000000000000ddddddd000000000000000888800000006777760444444440005d000000d500000000000
00000000000000000000d0d0d000000ffffffff000000000000000000000000d00000000000000888800000006777760446666440005d000000d500000000000
00000000005500000000ddddd000000ffffffff0000000000000000000000000d0000000000000888800000006666660466666640005d000000d500000000000
00000000055550000000dd9dd0000000ffffff00000000000000000000000000d000000000000088880000000dddddd0466666640005d000000d500000000000
00000000555555550000dd9dd00000000ffff00000000000000000000000000d0000000000000088880000000111111046bbbb640005d000000d500000000000
00000000000000000000ddddd00000000000000000000000000000000000ddd000000000000000888800000001111110444444440000d000000d000000000000
00000000000000000000ddddd0000000000000000000000000000000000d000000000000000005888850000001111110008888000000d000000d000000000000
00005500000000000000ddddd00000000000000000000000000000000000000000000000000000000000000001111110000000000000d000000d000000000000
000555550000d0000000ddddd00000000000000000055000000000000000000f00000000000000000000000001111110000000000000d000000d000000000000
00555555500ddd000000ddddd00000000000000000555500000000000000000f00000000000000000000000001111110000000000000d000000d000000000000
00000000000ddd000000ddddd00000000000000055555550000000000000000f00000000000000000000000000000000000000000000dddddddd000000000000
0000000000ddddd000d0ddddd000000000dd00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000ddddd000d0ddddd0d000000dddd000000000000000d000000000000000000000000000000000000000000000000000000000000000000000000000
000000000ddddddd0dd0ddddd0ddd0000dddd000000000000000dd00000000000000000000000000000000000000000000000000000000000000000000000000
000000000000d0000dd0ddddd0ddddd0dddddd00000000000000ddd0000000000000000000000000000000000000000000000000000000000000000000000000
000000000000d0000dd0ddddd0dddddd0d0dd000000000000000ddddd00000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000099999090090999900099990999009990000000000000000000000000000000000000000000000000000000000000000000
00000500005000000000000000000000900090090900000090000900909009000000000000000000000000000000000000000000000000000000000000000000
00000550055000000000000000000000900090090900000090000900909009000000000000000000000000000000000000000000000000000000000000000000
00000555555000000000000000000000900099990999000099900900909009000000000000000000000000000000000000000000000000000000000000000000
00805555555508000000000000000000900090090900000090000900909009000000000000000000000000000000000000000000000000000000000000000000
08285595595582800000000000000000900090090900000090000900909009000000000000000000000000000000000000000000000000000000000000000000
00222555555222000000000000000000900090090999900099990900909990000000000000000000000000000000000000000000000000000000000000000000
00022255552220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00002255552200000000000000000000000000000000000000000000000000000000000000002255552200000000000000000000000000000000000000000000
00888054450888000000000000000000000000000000000000000000000000000000000000888254450888000000000000000000000000000000000000000000
08828005500828800000000000000000000000000000000000000000000000000000000002222225500828800000000000000000000000000000000000000000
082228000082228000000000000000000000000000000000000000000000000000000000098e7ea0008222800000000000000000000000000000000000000000
8228280000828228000000000000000000000000000000000000000000000000000000000988e8a0008282280000000000000000000000000000000000000000
822828000082822800000000000000000000000000000000000000000000000000000000098888a0008282280000000000000000000000000000000000000000
828228000082282800000000000000000000000000000000000000000000000000000000029aaa00008228280000000000000000000000000000000000000000
2282280000822822000000000000000000000000000000000000000000000000000000000229a200008228220000000000000000000000000000000000000000
22822855558228220000000000000000000000000000000000000000000000000000000002999a11118228220000000000000000000000000000000000000000
02282855558282200000000000000000000000000000000000000000000000000000000002555501108282200000000000000000000000000000000000000000
02282805508282200000000000000000000000000000000000000000000000000000000002255801108282200000000000000000000000000000000000000000
02222801108222200000000000000000000000000000000000000000000000000000000002222801108222200000000000000000000000000000000000000000
02222801108222200000000000000000000000000000000000000000000000000000000002222801108222200000000000000000000000000000000000000000
02222801108222200000000000000000000000000000000000000000000000000000000002222801108222200000000000000000000000000000000000000000
02222801108222200000000000000070070000000000000000000000000000000000000002222801108222200000000000000000000000000000000000000000
02222801108222200000000000000777777000000000000000000000000000000000000002222801108222200000000000000000000000000000000000000000
02222801108222200000000000007007700700000000000000000000000000000000000002222801108222200000000000000000000000000000000000000000
02222801108222200000000000086007700780000000000000000000000000000000000002222801108222200000000000000000000000000000000000000000
0222280110822220000000000088d6777778d8000000000000000000000000000000000002222801108222200000000000000000000000000000000000000000
022228011082222000000000008ddd67778ddd800000000000000000000000000000000002222801108222200000000000000000000000000000000000000000
02222801108222200000000008d65d67778d55d88000000000000000000000000000000002222801108222200000000000000000000000000000000000000000
2222880110882222000000008d5865866855655dd800000000000000000000000000000022228801108822220000000000000000000000000000000000000000
2222280110822222000000088585865d555686555d80000000000000000000000000000022222801108222220000000000000000000000000000000000000000
222222011022222200000085888558655568588655d8000000000000000000000000000022222201102222220000000000000000000000000000000000000000
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
00000000000000000000000000000000000000000900090099009000999900099999009900900090999909990000000000000000000000000000000000000000
00000000000000000000000000000000000000000909090900909000900000000900090090909090900009009000000000000000000000000000000000000000
00000000000000000000000000000000000000000909090900909000900000000900090090909090900009009000000000000000000000000000000000000000
00000000000000000000000000000000000000000909090900909000999000000900090090909090999009990000000000000000000000000000000000000000
00000000000000000000000000000000000000000909090900909000900000000900090090909090900009009000000000000000000000000000000000000000
00000000000000000000000000000000000000000909090900909000900000000900090090909090900009009000000000000000000000000000000000000000
00000000000000000000000000000000000000000090900099009990900000000900009900090900999909009000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000ffff000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000ffffff00000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000ffffffff0000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000d0d0d000000ffffffff0000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000d0d0d000000ffffffff0000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000005500000000ddddd000000ffffffff0000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000055550000000dd9dd0000000ffffff00000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000555555550000dd9dd00000000ffff000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000ddddd000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000ddddd000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000005500000000000000ddddd000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000555550000d0000000ddddd000000000000000000550000000000000000000000000000000000000000000
000000000000000000000000000000000000000000555555500ddd000000ddddd000000000000000005555000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000ddd000000ddddd000000000000000555555500000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000ddddd000d0ddddd000000000dd0000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000ddddd000d0ddddd0d000000dddd000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000ddddddd0dd0ddddd0ddd0000dddd000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000d0000dd0ddddd0ddddd0dddddd00000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000d0000dd0ddddd0dddddd0d0dd000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000d000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000d000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000ddd00000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000ddddddd000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000d00000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000d0000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000d00000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000ddd000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000d000000000000000000000000000000000000000000000000000000000000
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
0003000100000000000000000001010303030303030103030000000000000101030303030000000000000101010103010003030300030303010101010303030003030303030303030303030303030000030303030303030303030303030300000303030303030303000003030303000003030303030300000000000000000000
0000000000000000000000010101010100000000000000000101010000010100000000000000000000010100000101000000000000000000000000000001010001010000000000000000000000000000010100000000000000030000000000000101010101000000000100000000000003030101010100000003030000000000
__map__
0000000000010101010101010000000001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101
0000000000010202050202010000000001010d02028c02020d02028c02020d0101020202020201020202020202020201018c0202020202020202020202028c0101020202020202010202020202020201010202020202020202020202020202010104020202020263020202646564020101000000000000000000000000000001
0000000000010018191a000100000000010106000000000000000000000008010106420000080106000000000054080101060000461e540000000000002c2f0101060000420000010000000000000801019b00999a999a999a999a009c0008010100000000000073520044747574000101000000000000000000000000000001
0000000000010618191a08010000000001010044000000000000004c00000001010000000000020050000000000000010100000000000000001f5a00292e52010100500000000002000000000000000101069ba9aaa9aaa9aaa9aa9c000000010106000000000000000000000000000101000000000000000000000000000001
0000000000010018191a0001000000000101060000000000000000000056080101000000005c01000000000000000001010000000000000000000000292e000101060000005c0001003c003d003e000101006600000000000000009d9e9d9e0101000101010000000000002f2a2f000101000000000000000000000000000001
0000000000010618191a080100000000010100000000000052000000000000010106000000080106004a000000560801010600000101010101010100292f2a01010001010101010106000000000008010106000000000000006a6cadaeadae010106010501000000005600000000000101000000000000000000000000000001
0000000000010018191a0001000000000101060000000000000000000000080101000000000001000000000000000001010000000401010502023900002b2b01010004010502023a00000000000000010100000000000000000000bdbebdbe010100010001000063000000606160000101000000000000000000000000000001
0000000000010618191a080100000000010100010101010101010101010100010100010101010101010101000101010101010101010101010101010050008b0101000101010101010101010100010101010001010100010101010101010101010106010001000073000000707170000101000000000000000000000000000001
0000000000010000000000010000000001010001010101010101010102020001010002040105023802020200020202010102020202020102020202000000080101000202020d018e8d8d8d8f00028c01010002040100020202020102020202010100010038000000000000000000000101000000000000000000000000000001
0000000000010101140101010000000001010001270202250202260100010101010001010101010106000000000008010106003c000801060000000000000001010600465a0801060000000000540801010101010100005000080106003c08010106010101010001010101010101010101000000000000000000000000000001
0000000000010202000202010000000001050001060000360000080100020201010002020202020100000000000000010100000000000100004200000000000101000000002801980098009800000001010501020200000000000100000000010100020202020002020102020202020101000000000000000000000000000001
00000000000106004000080100000000010101010000000000000001010100010106004800000801063c003d003e080101000000000002000000000000000801010688898a0002000000000000000801010001000044000000000200003d0801010600004a005000080106000000090101000000000000000000000000000001
0000000000010000000000010000000001020227000000000000003902020901010000000000000100000000000000010100000000000100000000000056000101000000002801980098009800000001010001000000000058000100000000010100000000000000000200000000000101000000000000000000000000000001
0000000000010688898a08010000000001000101003500000033000100000001010600000000080106000000000008010106003d00080106000000000000000101060000000801060000000000000801010001060000420000080106003e0801010600480000005c00013c003d003e0101000000000000000000000000000001
00000000000101010e010101000000000100040100000000000000010d0d0d010100000000000d0100000000000000010100000000000100000000000000000101000000000d018b0000000000008b0101003b000000000000000100000000010100000000000000000100000000000101000000000000000000000000000001
000000000000000a0b0c00000000000001010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101
0000010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000010202020202020202020201000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000010600100000110000120801000000000000000000000000000000000000000000000101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000101010000000000000000010000000000000000000000000000000000000000000001041b0202020201000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000001050100004d000000000001000000000000000000000000000000000000000000000101010101013f01000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000001390106000000000000080100000000000000c3c4c5c6c7000000000000000000000102020202021c01000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000001000246000000005a000001000000000000000000009394000000000000000000000106000000000801000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000001000000000000000000000100000000000000a000b6b7a4000000000000000000000100000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000106400000c0c1000000080100000000000000b0b1b2b3b4b5000000000000000000015e000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000100000000d0d10000000001000000000000000000960000000000000000000000000106000000000801000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000100000000e0e1000000000100000000000000000000a7a8000000000000000000000100000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000101060000f0f10015000801000000000000000000000000000000000000000000000101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000010400000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
a80100000e710127100e710186001270018600127001860000700197001e70020500235001d500205002550029500000000000000000000000000000000000000000000000000000000000000000000000000000
0001000012550105500d5500b5500955007550065500555004570045700457005570075700a5700e57014550185501e550215501f5001c5002d50000000000000000000000000000000000000000000000000000
490100001a0501405014050160501a0501905015050150501b0501a05016050180501d0501a050170001600017000160001800019000190002d50000000000000000000000000000000000000000000000000000
4a010000035600c650045500c640035400c6400154000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100001b0501b0501b0501b0501b0501d0501b0501d0501b0501d0501b0501b0501b0501b0501b0501b00000000000000000000000000000000000000000000000000000000000000000000000000000000000
010100001805018050180501805018050180501805018050180501805018050180501805018050180501805000000000000000000000000000000000000000000000000000000000000000000000000000000000
010100001a0501a0501a0501a0501a0501a0501a0501a0501a0501a0501a0501a0501a0501a0501a0501a05000000000000000000000000000000000000000000000000000000000000000000000000000000000
010100001c0501c0501c0501c0501c0501c0501c0501c0501c0501c0501c0501c0501c0501c0501c0501c05000000000000000000000000000000000000000000000000000000000000000000000000000000000
010100001d0501d0501d0501d0501d0501d0501d0501d0501d0501d0501d0501d0501d0501d0501d0501d05000000000000000000000000000000000000000000000000000000000000000000000000000000000
010100001f0501f0501f0501f0501f0501f0501f0501f0501f0501f0501f0501f0501f0501f0501f0501f05000000000000000000000000000000000000000000000000000000000000000000000000000000000
010100002105021050210502105021050210502105021050210502105021050210502105021050210502105000000000000000000000000000000000000000000000000000000000000000000000000000000000
010100002305023050230502305023050230502305023050230502305023050230502305023050230502305000000000000000000000000000000000000000000000000000000000000000000000000000000000
010100002405024050240502405024050240502405024050240502405024050240502405024050240502405000000000000000000000000000000000000000000000000000000000000000000000000000000000
0005000015050150501505015050150501505017050180501c0501f0502405024050240502405024050000000000001600016000160001600166002c600000000000000000000000000000000000000000000000
00090000230502e050180502e0001800018000180002d0002d0002d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
8f0100002065018450236501d450276501f6501e450246502445028650284502e65032650284503a650334503f650000000000000000000000000000000000000000000000000000000000000000000000000000
