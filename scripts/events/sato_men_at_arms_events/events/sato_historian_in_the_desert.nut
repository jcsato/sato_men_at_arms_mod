sato_historian_in_the_desert <- inherit("scripts/events/event", {
	m = {
		Dude = null,
		RandomBro = null,
	},
	function create()
	{
        local eventAText1 = "Trudging across the scorching sand, you suddenly hear the faint sound of a muffled voice coming from a nearby crag of rocks. Before you can react, a forearm erupts from the mound, followed closely by a head, gasping for breath. You watch in amazement as the rest of a man is arduously birthed from the stone and sand, his escape punctuated by panting and wheezing. As he pulls his last foot out, the sandy stranger looks around and, finally noticing you, offers a feeble wave.";
        local eventAText2 = "%SPEECH_ON%Well hello there, fine sirs! Pardon me for being so disheveled - as you saw, I found myself rather, er, mired in the local terrain. Have you happened to see anyone else in the area? A group of fighters, about ten men strong?%SPEECH_OFF%";
        local eventAText3 = "You shake your head, informing him you\'ve encountered no other companies nearby.";
        local eventAText4 = "{%SPEECH_ON%Oh, so you\'re mercenaries as well? Splendid, splendid! I am the scribe of the Sable Company, a mercenary band of some renown. Our captain led us south in search of a mythical repository sunken into the sands. We were convinced it held lost secrets regarding the company\'s origins. During our search, however, we ran afoul of some creatures that the locals call \'Ifrit\''. That arid lump I crawled out of constitutes the remains of one such creature.%SPEECH_OFF%";
        local eventAText5 = "He points to his former prison in an attempt to illustrate where the creature\'s remains end and the desert begins. He fails.";
        local eventAText6 = "%SPEECH_ON%I remember striking it and being buried in its remains as it died, but I blacked out after that. If you\'ve not seen them, I fear the rest of the company may not have survived, we were in a bad way before I went down.%SPEECH_OFF%";
        local eventAText7 = "You glance at the innumerable other clumps of rock strewn about and imagine a sellsword dead or dying under each one, eaten by the desert, the unassuming sand and stone, their cairns. The line of thinking grows increasingly uncomfortable the more thought you give it, and you turn your attention back to the man. You tell him you think you've been to the repository he mentioned, and recovered an ancient book from it.";
        local eventAText8 = "%SPEECH_ON%Really? That\'s remarkable! Please, let me see it, it could contain the secrets for which we so desperately searched! I may well be the last of the company, and I must see our quest through lest the sacrifices we made coming here be in vain! I\'ll even work for you, fight under your banner! I assure you, I\'m quite a capable fighter and watchman and, er, digger. What do you say?%SPEECH_OFF%";
        local eventAText9 = "You ponder the offer. It\'s certainly true that no one in the company has a better chance of getting something useful out of the book. Perhaps it would be worth taking him on?";

		m.ID = "event.sato_historian_in_the_desert";
		m.Title = "Along the way...";
		m.Cooldown = 99999.0 * World.getTime().SecondsPerDay;
		m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_161.png[/img]{" + eventAText1 + eventAText2 + eventAText3 + eventAText4 + eventAText5 + eventAText6 + eventAText7 + eventAText8 + eventAText9 + "}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Very well. Welcome to the %companyname%.",
					function getResult( _event ) { return "B"; }

				},
				{
					Text = "We have no need of you.",
					function getResult( _event ) { return 0; }

				}
			],
			function start( _event )
			{
			}

		});
		
        local eventBText1 = "The man thanks you profusely. %randombro% walks up and grunts at him.";
        local eventBText2 = "%SPEECH_ON%Well, I suppose we oughtta come up with a proper title for ya, what with you joining the company straight outta the ground all spectacular like that. What'd you prefer, Rockhugger or Sand-Shat?%SPEECH_OFF%";
        local eventBText3 = "The scribe gives nervous laugh and scrambles for an alternative.";
        local eventBText4 = "%SPEECH_ON%Eh, perhaps something a little less...here, how about Earthborne?%SPEECH_OFF%";
        local eventBText5 = "%randombro%\'s eyes light up. He looks impressed.";
        local eventBText6 = "%SPEECH_ON%Hey cap\', he really does know his words! Maybe he actually can figure out that book!%SPEECH_OFF%";

        m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_161.png[/img]{" + eventBText1 + eventBText2 + eventBText3 + eventBText4 + eventBText5 + eventBText6 + "}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Maybe he\'ll fit in after all.",
					function getResult( _event )
					{
						World.getPlayerRoster().add(_event.m.Dude);
						World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"historian_background"
				]);
				_event.m.Dude.setTitle("Earthborne");
				_event.m.Dude.getBackground().m.RawDescription = "You found %name% in the desert, wrapped in the remains of an Ifrit he claims to have killed. Judging his former company to be lost or slain, he joined you, on the promise of translating the book you found in the sunken library. His excessive politeness grates at the best of times, but at least the man shows talent as a fighter.";
				_event.m.Dude.getBackground().buildDescription(true);
				
				local traits = _event.m.Dude.getSkills().query(Const.SkillType.Trait);
				foreach(t in traits)
				{
					if(t.getID() != "background.historian")
						_event.m.Dude.getSkills().removeByID(t.getID());
				}

				_event.m.Dude.getSkills().add(new("scripts/skills/traits/optimist_trait"));
				_event.m.Dude.getSkills().add(new("scripts/skills/traits/dexterous_trait"));

                local items = _event.m.Dude.getItems();
				if (items.getItemAtSlot(Const.ItemSlot.Head) != null)
					items.getItemAtSlot(Const.ItemSlot.Head).removeSelf();

				if (items.getItemAtSlot(Const.ItemSlot.Body) != null)
					items.getItemAtSlot(Const.ItemSlot.Body).removeSelf();

                items.equip(new("scripts/items/armor/ragged_surcoat"));
                items.equip(new("scripts/items/helmets/oriental/nomad_leather_cap"));

				_event.m.Dude.m.PerkPoints = 6;
				_event.m.Dude.m.LevelUps = 6;
				_event.m.Dude.m.Level = 7;

				_event.m.Dude.m.Talents = [];
				local talents = _event.m.Dude.getTalents();
				talents.resize(Const.Attributes.COUNT, 0);
				talents[Const.Attributes.Hitpoints] = 3;
				talents[Const.Attributes.MeleeSkill] = 3;
				talents[Const.Attributes.MeleeDefense] = 3;
				_event.m.Dude.m.XP = Const.LevelXP[_event.m.Dude.m.Level - 1];
				_event.m.Dude.fillAttributeLevelUpValues(Const.XP.MaxLevelWithPerkpoints - 1);

				Characters.push(_event.m.Dude.getImagePath());
				Characters.push(_event.m.RandomBro.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!Const.DLC.Desert)
			return;

		if (World.Assets.getOrigin().getID() != "scenario.sato_men_at_arms")
			return;

        if (!World.Flags.get("IsLorekeeperDefeated") || World.Flags.get("IsLorekeeperTradeMade"))
			return;

		local stash = World.Assets.getStash().getItems();
		local hasBlackBook = false;

		foreach( item in stash )
		{
			if (item != null && item.getID() == "misc.black_book")
			{
				hasBlackBook = true;
				break;
			}
		}

		if (!hasBlackBook)
			return;

		if (!World.getTime().IsDaytime)
			return;

		if (World.getPlayerRoster().getSize() >= World.Assets.getBrothersMax())
			return;

		local currentTile = World.State.getPlayer().getTile();

		if (currentTile.Type != Const.World.TerrainType.Desert || currentTile.HasRoad)
			return;

		local towns = World.EntityManager.getSettlements();
		local playerTile = World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(playerTile) <= 5)
				return;
		}

		local brothers = World.getPlayerRoster().getAll();
		m.RandomBro = brothers[Math.rand(0, brothers.len() - 1)];

		m.Score = 100;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([ "randombro", m.RandomBro.getName() ]);
	}

	function onClear()
	{
		m.Dude = null;
		m.RandomBro = null;
	}

});

