sato_men_at_arms_scenario <- inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		m.ID = "scenario.sato_men_at_arms";
		m.Name = "Men at Arms";
		m.Description = "[p=c][img]gfx/ui/events/event_78.png[/img][/p][p]As a seasoned group of soldiers, you\'ve fought campaign after campaign under many banners - and earned the spite of the peasantry in the process. After a brutal series of contracts leaves you under strength, how will you rebuild a proper company?\n\n[color=#bcad8c]Men at Arms:[/color] Start with three well-trained soldiers.\n[color=#bcad8c]Veterans:[/color] Training halls cost 50% less.\n[color=#bcad8c]Soldiers all:[/color] You can only hire combat backgrounds, and can never exceed 16 men in your roster.\n[color=#bcad8c]Subjugators:[/color] Start with poor relations to civilian factions.[/p]";
		m.Difficulty = 2;
		m.Order = 85;
		m.IsFixedLook = true;
	}

	function onSpawnAssets()
	{
		local roster = World.getPlayerRoster();

		for( local i = 0; i < 3; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = Time.getVirtualTimeF();
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([ "retired_soldier_background" ]);
		bros[0].getBackground().m.RawDescription = "%name% has been a stalwart part of the company for as long as you can remember. His unassuming arms bely his skill - you\'ve seen him face off against three sellswords at once with nothing more than his spear and shield, and win. The tight-lipped soldier has never let on to his full past, beyond that he used to serve a minor noble house that has since fallen into obscurity.";
		bros[0].getBackground().buildDescription(true);
		bros[0].setPlaceInFormation(3);

		local skills = bros[0].getSkills();
		skills.removeByID("trait.asthmatic");
		skills.removeByID("trait.frail");

		bros[0].m.PerkPoints = 2;
		bros[0].m.LevelUps = 2;
		bros[0].m.Level = 3;

		bros[0].m.Talents = [];
		local talents = bros[0].getTalents();
		talents.resize(Const.Attributes.COUNT, 0);
		talents[Const.Attributes.Bravery] = 2;
		talents[Const.Attributes.MeleeSkill] = 2;
		talents[Const.Attributes.MeleeDefense] = 2;

		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Offhand));
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Ammo));

		local weaponRoll = Math.rand(1, 100);
		local weapon;
		local shield;
		if (weaponRoll <= 75)
		{
			weapon = new("scripts/items/weapons/militia_spear");
			shield = new("scripts/items/shields/heater_shield");
		}
		else
		{
			weapon = new("scripts/items/weapons/boar_spear");
			shield = new("scripts/items/shields/kite_shield");
		}
		items.equip(weapon);
		items.equip(shield);
		shield.onPaintInCompanyColors();

		local helmetOptions = [
			"scripts/items/helmets/nasal_helmet",
			"scripts/items/helmets/reinforced_mail_coif"
		];
		if (Const.DLC.Wildmen)
			helmetOptions.push("scripts/items/helmets/nordic_helmet")

		local helmetRoll = Math.rand(0, helmetOptions.len() - 1);
		items.equip(new(helmetOptions[helmetRoll]));

		local armorRoll = Math.rand(1, 3);
		if (armorRoll == 1)
			items.equip(new("scripts/items/armor/gambeson"));
		else if (armorRoll == 2)
			items.equip(new("scripts/items/armor/basic_mail_shirt"));
		else if (armorRoll == 3)
			items.equip(new("scripts/items/armor/mail_shirt"));

		bros[1].setStartValuesEx([ "sellsword_background" ]);
		bros[1].getBackground().m.RawDescription = "A hard man by any measure, %name% has seen more than his fair share of fighting. A true veteran, the only company he holds truly close is his weathered, heavily used weapon - and his crowns. Many in the company look up to %name%\'s sort as the goal to aspire to. At the wages he commands you\'re not sure you like that, but you can\'t deny the man\'s skills.";
		bros[1].getBackground().buildDescription(true);
		bros[1].setPlaceInFormation(4);
		bros[1].m.PerkPoints = 1;
		bros[1].m.LevelUps = 1;
		bros[1].m.Level = 2;
		bros[1].getFlags().add("convincedToStayWithCompany");

		if (Math.rand(1, 100) <= 33)
			bros[1].setTitle("the Dog");

		bros[1].m.Talents = [];
		local talents = bros[1].getTalents();
		talents.resize(Const.Attributes.COUNT, 0);
		talents[Const.Attributes.Bravery] = 2;
		talents[Const.Attributes.Fatigue] = 1;
		talents[Const.Attributes.RangedDefense] = 3;

		local items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Offhand));
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Ammo));

		local weapon = "scripts/items/weapons/morning_star";
		if (Const.DLC.Unhold)
		{
			local weaponRoll = Math.rand(1, 100);
			if (weaponRoll <= 65)
				weapon = "scripts/items/weapons/longsword";
			else if (weaponRoll <= 90)
				weapon = "scripts/items/weapons/two_handed_mace";
			else if (weaponRoll <= 95)
				weapon = "scripts/items/weapons/polehammer";
			else
				weapon = "scripts/items/weapons/two_handed_flail";
		}
		items.equip(new(weapon))

		local helmet;
		if (Math.rand(1, 100) <= 70 || weaponRoll >= 90)
		{
			helmet = new("scripts/items/helmets/decayed_closed_flat_top_with_mail");
			helmet.setVariant(Math.rand(1, 2) == 1 ? 58 : 55);
		}
		else
		{
			helmet = new("scripts/items/helmets/decayed_full_helm");
			helmet.setVariant(Math.rand(1, 2) == 1 ? 59 : 56)
		}
		items.equip(helmet);

		local armorOptions = [
			"scripts/items/armor/mail_shirt",
			"scripts/items/armor/mail_hauberk",
			"scripts/items/armor/decayed_reinforced_mail_hauberk"
		];
		if (Const.DLC.Unhold)
		{
			armorOptions.push("scripts/items/armor/leather_scale_armor");
			armorOptions.push("scripts/items/armor/light_scale_armor");
		}

		local armorRoll = Math.rand(0, armorOptions.len() - 1);
		items.equip(new(armorOptions[armorRoll]));

		bros[2].setStartValuesEx([ "deserter_background" ]);
		bros[2].getBackground().m.RawDescription = "%name% didn\'t desert to escape war, but to escape his commanders - or so he claims. The man has adapted to mercenary life quite well and you can\'t deny his talent, but you have to wonder about the trustworthiness of a man wearing clearly stolen armor.";
		bros[2].getBackground().buildDescription(true);
		bros[2].setPlaceInFormation(5);

		local skills = bros[2].getSkills();
		skills.removeByID("trait.asthmatic");
		skills.removeByID("trait.craven");
		skills.removeByID("trait.fainthearted");
		skills.removeByID("trait.insecure");

		bros[2].m.PerkPoints = 1;
		bros[2].m.LevelUps = 1;
		bros[2].m.Level = 2;

		bros[2].m.Talents = [];
		local talents = bros[2].getTalents();
		talents.resize(Const.Attributes.COUNT, 0);
		talents[Const.Attributes.Fatigue] = 3;
		talents[Const.Attributes.MeleeSkill] = 2;
		talents[Const.Attributes.MeleeDefense] = 2;

		local items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Offhand));
		items.unequip(items.getItemAtSlot(Const.ItemSlot.Ammo));
		items.equip(new("scripts/items/weapons/hatchet"));
		items.equip(new("scripts/items/shields/buckler_shield"));
		items.equip(new("scripts/items/helmets/closed_flat_top_helmet"));
		items.equip(new("scripts/items/armor/mail_shirt"));

		World.Assets.m.BusinessReputation = 500;
		World.Assets.getStash().add(new("scripts/items/supplies/ground_grains_item"));
		World.Assets.getStash().add(new("scripts/items/supplies/cured_venison_item"));
		World.Assets.m.Money = World.Assets.m.Money;
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = World.EntityManager.getSettlements()[i];

			if (randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() >= 3)
				break;
		}

		local randomVillageTile = randomVillage.getTile();

		do
		{
			local x = Math.rand(Math.max(2, randomVillageTile.SquareCoords.X - 1), Math.min(Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 1));
			local y = Math.rand(Math.max(2, randomVillageTile.SquareCoords.Y - 1), Math.min(Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 1));

			if (!World.isValidTileSquare(x, y))
				continue;
			else
			{
				local tile = World.getTileSquare(x, y);

				if (tile.Type == Const.World.TerrainType.Ocean || tile.Type == Const.World.TerrainType.Shore)
					continue;
				else if (tile.getDistanceTo(randomVillageTile) == 0)
					continue;
				else if (!tile.HasRoad)
					continue;
				else
				{
					randomVillageTile = tile;
					break;
				}
			}
		}
		while (1);

		local settlements = World.FactionManager.getFactionsOfType(Const.FactionType.Settlement);

		foreach( i, h in settlements )
		{
			h.addPlayerRelation(-25.0, "You have a reputation as merciless soldiers");
		}

		local houses = World.FactionManager.getFactionsOfType(Const.FactionType.NobleHouse);

		foreach( j, k in houses )
		{
			k.setPlayerRelation(50.0);
		}

		World.State.m.Player = World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		World.Assets.updateLook(3);
		World.getCamera().setPos(World.State.m.Player.getPos());
		Time.scheduleEvent(TimeUnit.Real, 1000, function ( _tag )
		{
			Music.setTrackList([
				"music/civilians_01.ogg"
			], Const.Music.CrossFadeTime);
			World.Events.fire("event.sato_men_at_arms_scenario_intro");
		}, null);
	}

	function onInit()
	{
		World.Assets.m.BrothersMax = 16;

		if (!(World.Statistics.getFlags().get("SatoMenAtArmsEventsAdded")))
		{
			local mundaneEvents = IO.enumerateFiles("scripts/events/sato_men_at_arms_events");
			foreach ( i, event in mundaneEvents ) {
				local instantiatedEvent = new(event);
				World.Events.m.Events.push(instantiatedEvent);
			};
		}
		World.Statistics.getFlags().set("SatoMenAtArmsEventsAdded", true);
	}

	function onUpdateHiringRoster( _roster )
	{
		local garbage = [];
		local bros = _roster.getAll();

		foreach( i, bro in bros )
		{
			if (!bro.getBackground().isCombatBackground())
				garbage.push(bro);
		}

		foreach( g in garbage )
		{
			_roster.remove(g);
		}
	}

});
