﻿//The Tavern - The Golden Peak
//IMPORTANT NOTE
//The first time the PC enters the Myrellion Tavern, KaraQuest 1 triggers! Go to that doc for sweet deets. 
//https://docs.google.com/document/d/1G_hmZvUYehxytaCG2hL3n4CIBZWKMkLMx556ElHigNM/edit#heading=h.tuevrq58epfp

function goldenPeakBonusFunction():Boolean
{
	if(pc.characterClass == GLOBAL.CLASS_SMUGGLER) output(" Throw in a few more shady characters and a fist fight, and it'd feel like home!");
	output(" A holoscreen is set up just over the bar, showing reruns of Steph Irson: Galactic Huntress.");
	addButton(1,"Watch Screen",stephIrson4Go,undefined,"Watch Screen","That Steph Irson episode won't watch itself!");
	return false;
}

//[Bartender]
//Add to bar room descript: "A perky half-ausar girl with a blonde ponytail swishing behind her back is working the bar, bouncing between customers in ways that draw your eye to the short top and tight shorts she's wearing, and all the bare flesh on display.
function approachTheBartenderAtTheBar():void
{
	clearOutput();
	author("Savin");
	output("You take a seat at the bar and flag the perky half-ausar girl working behind it down. She comes over to you a moment later, flicking a rag over her shoulder and planting her hands on her jean-short clad hips. “<i>Hey, hun. What can I getcha?</i>”");
	
	//9999 Bar menu
	/*
	[Chitin Cracker]
	//A local favorite, the chitin cracker is made with a local strain of fungus that grows freely in the deeper caves on Myrellion. It tastes foul to anybody but a myr and it packs enough wallop to crack a nyrea's chitin, but it'll get you drunk for next to nothing.

	[Queen's Honey]
	//The Myrellion equivalent of an expensive bottle of wine, Queen's Honey is made from exactly what you might expect: the breast honey of a Gold Myr queen. The liquor made from it is as sweet as candy, expensive as hell, and as rich in taste as you need to be in cash to buy it. A favorite among the upper echelon of the Gold Myr, every bottle is unique and signed by the queen whose nectar produced it. 

	[Ausar Chaser]
	//Bartender's favorite! An energy drink mixed with vodka, the ausar chaser will get you revved up and ready for action - or drunk enough to go chasing your tail after a couple shots. {A few MORE shots and you might not remember you don't have a tail at all!}

	[Nyrean Knot]
	//Guaranteed to keep you in your place for a few hours: drop dead drunk on the bar's floor. Powerful, kicks like a mule, and stings like barbs going down. Only recommended for creatures with high alcohol tolerance or nothing to do tomorrow. 

	[Miniature Rahn]
	//A jello shot! No gel or goo creatures were harmed making this delicious, sweet drink. Though {the bartender / Candice} might have gone down on one beforehand to make it!

	[Fire Pepper]
	//A red myr staple, this red drink has little flecks of a local pepper floating in it. This drink bites like a red myr warrioress, and may or may not be laced with some of their aphrodisiac venom to boot. So yes, it literally bites - and you'll no doubt want to find a nice, warm, red-chitined beauty to snuggle up with afterwards. 

	[Your Number] replace on repeat with: [Quickie]*/
	//Tooltip: This bartender's cute as hell. Maybe you could hook up after her shift...?
}

function bartenderFlirt():void
{
	author("Savin");
	showBust("PLACEHOLDER");
	showName("\nBARTENDER");
	
	//PC Hasn't bought a drink:
	if(9999 == 9999)
	{
		output("You look the cute halfbreed up and down, eyes playing across all the lush, tanned skin on display. “<i>How about your number, first of all?</i>”");
		output("\n\nShe crosses her arms under her cut-off halter and gives you a look. “<i>C’mon, " + pc.mf("mister","miss") + ", I’m trying to work here... at least get a couple drinks first.</i>”");
	}
	//PC has bought at least 1 drink first. First Time. Once every 3 hours...
	else if(9999 == 0)
	{
		output("You look the cute halfbreed up and down, eyes playing across all the lush, tanned skin on display. “<i>How about your number, first of all?</i>”");
		output("\n\nThe bar girl giggles and casts a furtive look around, presumably to make sure her boss isn’t close at hand. Safe in the knowledge she’s the only person working at the moment, she flashes you a conspiratorial smile and says, “<i>Well... you’re cute, and it is about time I took a break... tell you what, why don’t we skip the boring parts and have some </i>real<i> fun?</i>”");
		output("\n\nBehind her, you can see her long, golden tail flick up excitedly. Her back end wiggles excitedly under her booty shorts, threatening to knock over the liquor stacked up behind the bar.");
		output("\n\nYou nod eagerly, and are quick to follow her out of the bar’s back door, down into the alleyway behind it.");
	}
	//Repeat Quickie. Once every 3 hours.
	else
	{
		output("You look the cute halfbreed up and down, eyes playing across all the lush, tanned skin on display. “<i>How about some more fun?</i>”");
		output("\n\nCandice looks around to make sure her boss isn’t anywhere nearby, then gives you a playful wink and sets her rags down on the bar. “<i>Well... I had fun last time, and I think I could squeeze in a quick break. Sound good?</i>”");
		output("\n\nYou nod eagerly, and are quick to follow her out of the bar's back door, down into the alleyway behind it.");
	}
}

//[Watch Screen]
//STEPH IRSON 4 GO (See Steph's Doc)
function stephIrson4Go():void
{
	clearOutput();
	author("Savin");
	showName("STEPH\nIRSON");
	showBust("STEPH_4");

	output("You take a seat at the bar and pick up the remote sitting unattended, flicking the Super-HD viewscreen nearby over to another channel. The first thing you stumble upon is the start of the latest episode of <b>Steph Irson: Galactic Huntress</b>, a popular nature show. Beneath the title script, a warning appears in large red letters: “<i>This Show Rated X, Adults Only, by the Galactic Entertainment Ratings Board for Graphic, Sexual, and Disturbing Imagery. You Have Been Warned.</i>” A smaller notice underneath announces “<i>This show brought to you by the New Texas Council for Entertainment,</i>” followed by a cute cartoon image of an overly-busty cow-girl giving you a wink and a thumbs up.");
	output("\n\nThe title card fades away, replaced with a shaky camera shot that’s exploding with obviously digital color - a small disclaimer at the screen’s bottom tells you that the camera is operating in nightvision mode, with computer coloration added in real time by the producer A.I. The view resolves into a picture of the show’s host, Steph Irson, wearing her familiar khaki short-shorts and shirt, straining against the sheer size of her massive bust.\n\nThe hostess doesn’t look much like the iconic nature presenter you remember from years past: she’s sporting a pair of cute little cat ears atop her head that twitch and fidget as she moves, and her lips and eyes glisten with a metallic gray. Perhaps most noticeable, though, is her immense bust, more than double in size over the perky D-cups she sports in her promotional material.\n\nYou don’t think that shirt of hers is going to hold up to much - even a deep breath might burst those buttons and let her tits pop free on galactic TV. A big three-optic night vision rig is stuck on her forehead, awkwardly hooked around her kitty-ears.");
	output("\n\n“<i>We’re here on Myrellion, one of the most dangerous and unforgiving worlds in the new Planet Rush,</i>” her excited New Brisbaner accent offset by a tinge of bubbly bimbo. “<i>It’s, like, really dark here in the caverns below the surface, where all int.. int.. smart life on this world lives!</i>” She taps her night vision goggles for emphasis, grinning at the camera. “<i>But we’re on even footing now, thanks to our friends at Xenogen, who’re nice enough to give us these cute goggles!</i>”");
	output("\n\nShe bounces giddily, causing her bovine-like bosom to jiggle like gel under her shirt. “<i>Now, we’re here to find what’s gotta be the coolest species here on Myrellion, a planet full of insect-type creatures: the nyrea! A nyrea queen, to be precise! Nyrea flip what you and I know about biological sex right on its head, cuz the females have pseudo-penises and the males have genital slits just like pussies. Oops, I mean vaginas!</i>”");
	output("\n\nSteph giggles and turns away from the camera, start to walk through the narrow, winding caverns. “<i>Nyrean females vie for dominance among their own kind like old-earth animals, with submissive losers being forced to carry alphas’ eggs after the fight. Eggs they get through reverse sex with a male: inserting their pseudo-penis in his genital slit and extracting semen from little sacs inside him. Pretty nifty, huh? So today, I’m on the hunt for the biggest, baddest alpha nyrea I can find and see if we can get this strange, unique twist on mating on camera for you viewers at home! I’ve done a little scouting, and I think I’ve found a pretty likely place to find one: a deep cavern just up the, uh, up the cave here, covered in glowing moss and cave drawings.</i>”");
	output("\n\nA few moments later and the Huntress has arrived at the cave in question: a big crack in the wall surrounded by softly glowing blue moss that’s been artificially arranged into a swirling pattern around the cavern entrance, several concentric circles that make the passage seem much bigger and more intimidating than it actually is. A few small bushes grow from the ground nearby, forming a sweeping approach to the cave, almost like a manor house’s cultivated garden. Steph wasn’t kidding when she said nyrean queen!");
	output("\n\n“<i>Right, ‘ere we are, there. I’m gonna have to be incredibly careful from here on out, unless I want to end up with a belly full of eggs. Nyrea are aggressive breeders, and alphas love to make other people carry their eggs for them - I’m just a walking incubator to these ovipositing beauties. I’m just shivering thinking about it,</i>” Steph adds, hugging her arms around herself. In the ultra-HD color on screen, you can’t help but notice a dark splotch suddenly form on her shorts between her legs. The camera drone immediately focuses in on it, until Steph reaches out and gives it a swat.");
	output("\n\n“<i>Alright, it’s like, time to go get a look at a big, bad nyrean queen. Follow me!</i>” Steph whispers, adjusting her goggles and starting to creep towards the darkened tunnel entrance.");
	output("\n\nJust as she’s about to step through the cavern entrance, a woman steps out, smacking right into Steph and sending both of them tumbling to the ground. The camera zooms in on the alien woman, an insectile girl with a pair of big, bare breasts over a natural corset of chitin and long, elfin ears growing from her head. She lands on her ass with an “<i>oomph,</i>” rubbing her head where Steph bonked into her.");
	processTime(6);
	clearMenu();
	addButton(0,"Next",stephIrsonEpisode4Part2);
	addButton(1,"Stop Watching",mainGameMenu);
}

function stephIrsonEpisode4Part2():void
{
	clearOutput();
	author("Savin");
	showName("STEPH\nIRSON");
	showBust("STEPH_4");
	output("“<i>Ah, I’m sorry, I didn’t... I didn’t see you there!</i>” the alien girl groans, blinking hard.");
	output("\n\n“<i>Crikey! It’s a nyrea!</i>” Steph shouts, leaping to her feet. “<i>Are you getting this, camera? A live nyrean female, right in front of me. I’ve gotta subdue ‘er quick, or I’m gonna get stuffed with eggs!</i>”");
	output("\n\nThe alien girl blinks. “<i>B-but I’m a male...</i>”");
	output("\n\nBefore the alien not-female can finish her sentence, Steph’s on her like a sack of bricks, barreling her back to the cave floor and pinning her wrists to the ground. The nyrea squirms under Steph’s grasp, trying and failing to get her - his? - face out of Steph’s massive tits. All he ends up succeeding at is spreading his legs around Steph’s waist, and the camera dutifully zips around and sticks itself under Steph’s big, upturned booty, showing off the hairless gash between the nyrea’s legs, drooling moisture as his submission instinct kicks into overdrive.");
	output("\n\n“<i>Nooooo, I already have a mistress,</i>” the nyrea cries, flopping helplessly back. “<i>Don’t egg me! Mistress Taivra will be so mad if I come back full of eggs.</i>”");
	output("\n\nSteph rises to her knees, straddling the defeated insect boy. “<i>What do you mean egg </i>you<i>? You’re, like, the one who was gonna stuff </i>me<i> with eggs!</i>”");
	output("\n\n“<i>I’m a male!</i>” the nyrea huffs, crossing his arms under his D-cups tits. As if to emphasize the point, the camera swings back around to a view of Steph’s backside, resting just over the male’s genital slit, her khaki shorts soaking up a little of his rampant moisture.");
	//if PC has met Iryn:
	if(flags["MET_IRYN"] != undefined)
	{
		output("\n\n“<i>Oh, hey, is that me on the screen thing?</i>” Iryn says, walking over to sit beside you. “<i>Wow, do I... do I really look that fat?</i>”");
		output("\n\nYou roll your eyes and assure Iryn that the camera adds several pounds.");
		if(pc.isMischievous()) output(" Mostly to Steph’s tits and ass.");
		output(" After a moment, “<i>Wait, that’s really you?</i>”");

		output("\n\n“<i>Yeah! I was just walking out of my old mistress’s cave when this really weird offworlder woman jumped me. I kept trying to tell her I was a male, and all I wanted was to go gather some food, but she just scream about eggs and beat me up. I’d be mad about it, but she’s actually the reason I managed to escape my mistress anyway. See, look!</i>”");
		output("\n\nBack on screen, ");
	}
	else output("\n\n");
	output("Steph blushes and scrambles off. “<i>So... you’re not gonna try and fuck me silly?</i>”");
	output("\n\n“<i>No! What... what kind of weirdo do you think I am?</i>”");
	output("\n\n“<i>I dunno. It’s, like, really out of the ord... ordin.. uh, kinda weird that you’re not,</i>” Steph admits. “<i>Everything else I meet does,</i>” she adds, twirling a lock of golden hair.");
	output("\n\nThe nyrea blinks, but accepts Steph’s hand and pulls herself to her feet. “<i>I guess it’s the same everywhere. Even where you offworlders are from, huh?</i>”");
	output("\n\nSteph giggles. “<i>I don’t mind anymore, really. I guess I’ve just, like, gotten used to everything wanting to use my body like a cute little fucktoy.</i>”");
	output("\n\n“<i>And what a fucktoy it is,</i>” a third voice booms from inside the cave. A second nyrea steps out, clutching a long spear and wearing padded chainmail that just barely conceals her bust... and the massive, half-hard cock swinging between her legs. The camera zooms in, ducking under Steph’s ass to get an angle on the beast restrained by the nyrea’s chainmail bikini bottom. “<i>If you two had kept wrestling much longer, I might have had to start jacking off. But now that I have your attention, I guess you can take care of my big, thick problem here with your... cute little fucktoy of a breeder body, can’t you?</i>”");
	processTime(6);
	pc.lust(3);
	clearMenu();
	addButton(0,"Next",stephIrsonEpisode4Part3);
	addButton(1,"Stop Watching",mainGameMenu);
}

function stephIrsonEpisode4Part3():void
{
	clearOutput();
	author("Savin");
	showName("STEPH\nIRSON");
	showBust("STEPH_4_NUDE");
	output("The nyrea takes a long step forward, her hips swaying seductively towards Steph. “<i>Besides, I can’t have just anybody running up and attacking my favorite little bitch, can I?</i>” she coos, swatting the male on the ass as she passes by. “<i>Why don’t you slip out of the fuck-me outfit of yours and spread your legs. Iryn here’s just given me a ripe, fertile clutch of eggs that are desperate for somewhere to go...</i>”");
	output("\n\nSteph gulps, taking a defensive step back. “<i>Aww, c’mon!</i>” she groans, though the camera doesn’t fail to catch her thumbs hooking into her belt and yanking her pants down, revealing the silver lips of her pussy.");
	output("\n\n“<i>Aww, what an eager slut,</i>” the nyrean alpha grins, planting her spear head-first in the ground and stepping forward to plant a hand on Steph’s waist. Her other hand snakes down to her shaft, starting to stroke the bulge in her panties, slowly working them off her hips. They clatter to the ground, letting a foot of turgid, arm-thick meat flop free between her legs. Steph’s eyes go wide at the sight of it, and the camera pans to show her silvery pussy already gleaming with excitement. She takes another step back, followed immediately by the nyrea alpha, whose cock jumps when Steph’s bare leg brushes against it.");
	output("\n\nBefore the Galactic Huntress and the nyrean alpha can get too far, however, her male submissive catches the camera’s attention, creeping up behind his mistress. ");
	if(flags["MET_IRYN"] != undefined)
	{
		output("“<i>This is the good part,</i>” Iryn says giddily, fidgeting in {his/her} seat just enough to make {his/her} tits jiggle enticingly under {his/her} shirt. “<i>Watch this!</i>”");
		output("\n\nOn screen, Iryn");
	}
	else output("The male");
	output(" takes a nervous step forward, looks at the camera, and then charges his mistress from behind, slamming into both her and Steph, and sending them both tumbling into the nearest bush.");

	output("\n\n“<i>Suck it, whores!</i>” ");
	if(flags["MET_IRYN"] != undefined) output("Iryn");
	else output("the male");
	output(" cheers as they go tumbling. “<i>That’s for filling me with so many eggs all those years!</i>” ");

	output("\n\nThe camera darts down after Steph, diving into the bush - and what looks like a chasm hidden beneath it. Steph screams, falling through thick vines into what amounts to a pit filled with squirming roots and strange, brightly-colored juices. She lands suspended over the pit of slime, arms and legs tangled in a mass of vines. The nyrea is nowhere to be seen.");
	output("\n\n“<i>Whew, that was a close one, wasn’it?</i>” Steph says, breathing a sigh of relief. “<i>I was gonna get egged for sure. And, like, I");
	if(silly) output(" totes");
	else output(" totally");
	output(" could have broken my neck falling like that!</i>”");
	processTime(6);
	pc.lust(3);
	clearMenu();
	addButton(0,"Next",stephIrsonEpisode4Part4);
	addButton(1,"Stop Watching",mainGameMenu);
}

function stephIrsonEpisode4Part4():void
{
	clearOutput();
	author("Savin");
	showName("STEPH\nIRSON");
	showBust("STEPH_4_NUDE");
	output("Steph starts to move, trying to get up out of the mass of vines... when the very roots around her start to move, squirming around her limbs. One of the tips come into sight, drawing the camera’s eye: it’s tipped with a bulbous, drooling crown that splatters Steph’s cheek with moisture as it moves. In the dim light, you could be forgiven for thinking that it was a great big tentacle cock.");
	output("\n\n“<i>Crikey, not again!</i>” Steph squeals, struggling against the viney hold on her limbs. More tentacles squirm down from on high, dangling down around her, crawling across her body, tearing away the straining cloth of her shirt and wrapping around her huge tits, squeezing a squirt of milk out of her teats. She yelps, making the mistake of opening her mouth as a particularly daring vine brushes past her cheek. Sensing the defenseless opening, it darts in eagerly, plugging her maw with a squirming mass of green vine.");
	output("\n\nAs it fucks its way into Steph’s mouth, a small disclaimer appears at the bottom of the screen, telling you that the U.G.C. Scout Authority and the Entertainment Board are not responsible for the content of live television, and that the species colloquially called “<i>cock vines</i>” should be avoided at all costs. <b>Viewer discretion is advised</b>.");
	output("\n\nThe camera zooms in on Step’s mouth as the tentacle vine squirms past her silver lips, plunging deep down her throat. Her eyes go wide, filled with panic, and the tentacle in her mouth swells and discharges, liquid visibly surging through it and into Steph. More tentacles slither down her body as the first works, lifting her upright and spreading her legs wide. Her boobs bounce gaily, squirting milk over the vines and the camera drone, splattering the lens for a moment. By the time it cleans itself off, a pair of particularly wide-tipped vines have latched onto the bovine aussie’s teats, suckling the milk from her oversized bosom, engorging themselves on her tremendous bounty. More vines coil around her long legs and thick thighs, splaying them and crawling their way slowly but surely towards the glistening silver lips of her drooling cunt.");
	output("\n\nSteph struggles feebly against her tentacle restraints, her resistance slowly fading away to limp submission as the tentacles drain her milk and pump her full of their own juices. Her silvery-blue eyes roll back as a particularly meaty tentacle squirms its way into her cunt, spreading her wide over its turgid length. Its bulbous head vanishes, only visible as it bulges her gut with the sheer depth and size of its penetration. She screams in pleasure around the squirming vine, her body convulsing around the twin tentacles. The camera shifts in for a close up of Steph’s pussy, and the trickle of purple goop spilling out around the vine - the tentacle creature’s seed, no doubt, filling her womb beyond capacity.");
	output("\n\nHer whole body goes stiff a second later, drawing the drone around to her big, jiggly backside as a third, smaller vine spreads her cheeks in a desperate bid to get at her last unfilled hole. Its bulbous, cock-like head spurts a thick coat of purple spunk over Steph’s ass, using its own cum as lube to worm its way through her clenched behind. She screams again as the vine vanishes inside her, completing the three-way fucking she’s fallen into with a powerful, thigh-drenching orgasm.");
	processTime(6);
	pc.lust(5);
	clearMenu();
	addButton(0,"Next",stephIrsonEpisode4Part5);
	addButton(1,"Stop Watching",mainGameMenu);
}

function stephIrsonEpisode4Part5():void
{
	clearOutput();
	author("Savin");
	showName("STEPH\nIRSON");
	showBust("STEPH_4_NUDE");
	output("The tentacles are relentless, single-minded in their motions to pump Steph full of purple, viscous seed. Her belly swells with the sheer volume of plant-spunk flooding into her womb and both ends of her gut, distending even more as the tentacles visibly squirm inside her, straining her body to its limits. Minutes fly by in vigorous fucking, the tentacles drilling deeper and deeper into Steph’s abused body, joined by even more small vines that worm their way into her holes beside their larger cousins. Every root and vine in the bush seems to be trying to wriggle its way into her, to give the Huntress its load of thick, creamy plant spunk.");
	output("\n\nBy the time they’re done with her, Steph’s as purple as a grape, slathered with plant spooge from head to toe, still trickling milk as the vines latched onto her breasts release her. She sputters and coughs as the vine in her mouth withdraws, giving her a final facial shot across her cheeks in glorious close-up high definition. Her eyes flutter as the last squirts of cum plaster her gray lips, and her tongue laps it up with lazy hunger. She gives a full body shiver, drawing the camera’s eye towards her crotch as the tentacles buried in her twat slowly slither out, drawing out another screaming orgasm from the show’s host as they pop out, splattering her thighs with thier cum and hers.");
	output("\n\nSteph slumps against the restraints still around her limbs, breathing hard and shivering with the aftershocks of repeated orgasm, completely at the plant’s mercy. However, it seems done with her now that she’s utterly filled with its seed. The camera follows her as the tentacles draw her limp body back up through the bush over the pit and deposit her back on the surface, plopping her back on the stone cavern floor in a pool of purple spunk. You can see one tentacle, however, still outside the pit, attached firmly to the Galactic Huntress’s backside.");
	output("\n\n“<i>Oof,</i>” Steph groans, rolling onto her hand and knees, ass in the air and face to the camera. “<i>Well, that’s it for another episode of </i>Steph Irson<i>... ugh, what’s that on my... uh, </i>Steph Irson’s Galactic Huntress<i>. Join us next week for... agh, what the-</i>” she gasps as the tentacle behind her flicks up, its bulbous cockhead peeking up to look at the camera, drooling from its cumslit. The camera flies over to take a look, showing where the vine’s cockhead shifts into plant-like vine... and then travels down to join with Steph’s backside, just over her ass, foliage merging with flesh. She moans, and the tail squirms around, batting at the camera until it flies back away.");
	output("\n\n“<i>Like, um, next week we’ll be... uh,</i>” Steph slurs, her new cock-tail vanishing between her legs. “<i>We’ll be- gaaaaahhhhhh!</i>”");
	output("\n\nThe tail plunges into her, pumping feverously behind her. She gives a startled squeal, slumping forward onto her big, milky jugs as her new appendage gets used to her. The camera feed fades to black, telling you to tune in next week for another exciting episode of <i>Steph Irson, Galactic Huntress</i>.");
	processTime(6);
	pc.lust(7);
	clearMenu();
	addButton(0,"Next",mainGameMenu);
}