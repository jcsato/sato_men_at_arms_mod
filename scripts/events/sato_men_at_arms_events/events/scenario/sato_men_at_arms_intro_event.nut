sato_men_at_arms_intro_event <- inherit("scripts/events/event", {
	m = {},
	function create()
	{
		m.ID = "event.sato_men_at_arms_scenario_intro";
		m.IsSpecial = true;
		m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_31.png[/img]You weigh the bag of crowns in your hand and study it, its contents the most recent reward for your services. War is the seed sown by the ambitions of petty lords and power-hungry nobles; gold like this is merely the crop harvested from the fields.\n\nYou put the bag down and take stock of the company. Its ranks have dwindled in recent months, with recruit after recruit dying to their inexperience. %randomname1% never kept his shield up and finally caught an axehead with his throat. %randomname2% the apprentice got separated from the shieldwall and a knight gored him. That historian whose name you could never remember somehow managed to impale himself on his own spear. And yesterday %randomname3% the lumberjack, for all his promise, panicked and was cut down with his back to the enemy.\n\nAll that\'s left now are the veterans, your earlier musing ridiculous as it compares these battle-hardened killers to farmers. Their years of waging war are evident from the scars that riddle their bodies and the practiced efficiency with which they tend to their equipment. In the end, these are the only men you\'ve ever been able to rely on.\n\nIt\'s time to rebuild. Veterans or no, you haven\'t the strength to go back to the nobles. Yet. You\'ll need to work with the villages, help them with their petty brigand problems while you replenish the roster. But no more greenhorns who\'ve never seen a battle in their lives. You\'ll do it right this time, with real soldiers and proper training.\n\nAnd then, to the fields once more.",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "War awaits.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				Banner = "ui/banners/" + World.Assets.getBanner() + "s.png";
			}

		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		m.Title = "The Men at Arms";
	}

	function onPrepareVariables( _vars )
	{
		local brothers = World.getPlayerRoster().getAll();
		_vars.push([ "randomname1", Const.Strings.CharacterNames[Math.rand(0, Const.Strings.CharacterNames.len() - 1)] ]);
		_vars.push([ "randomname2", Const.Strings.CharacterNames[Math.rand(0, Const.Strings.CharacterNames.len() - 1)] ]);
		_vars.push([ "randomname3", Const.Strings.CharacterNames[Math.rand(0, Const.Strings.CharacterNames.len() - 1)] ]);
	}

	function onClear()
	{
	}

});
