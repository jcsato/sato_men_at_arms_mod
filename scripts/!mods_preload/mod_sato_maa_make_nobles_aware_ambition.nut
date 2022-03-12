::mods_hookNewObject("ambitions/ambitions/make_nobles_aware_ambition", function(mnaa) {
	local onUpdateScore = ::mods_getMember(mnaa, "onUpdateScore");

	mnaa.onUpdateScore = function() {
		if(World.Assets.getOrigin().getID() != "scenario.sato_men_at_arms")
			onUpdateScore();
		else
		{
			if (World.Assets.getBusinessReputation() >= 1050 && World.FactionManager.isGreaterEvil())
			{
				m.IsDone = true;
				return;
			}

			m.Score = 10;
		}
	}
}, false);
