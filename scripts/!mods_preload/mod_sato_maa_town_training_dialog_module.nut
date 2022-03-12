::mods_hookExactClass("ui/screens/world/modules/world_town_screen/town_training_dialog_module", function(ttdm) {
	local queryRosterInformation = ::mods_getMember(ttdm, "queryRosterInformation");
	local onTrain = ::mods_getMember(ttdm, "onTrain");

	ttdm.queryRosterInformation = function() {
		local settlement = World.State.getCurrentTown();
		local brothers = World.getPlayerRoster().getAll();
		local roster = [];

		foreach( b in brothers )
		{
			if (b.getLevel() >= 11)
				continue;

			if (b.getLevel() >= 7 && World.Assets.getOrigin().getID() == "scenario.manhunters" && b.getBackground().getID() == "background.slave")
				continue;

			if (b.getSkills().hasSkill("effects.trained"))
				continue;

			local background = b.getBackground();
			local e = { ID = b.getID(), Name = b.getName(), Level = b.getLevel(), ImagePath = b.getImagePath(), ImageOffsetX = b.getImageOffsetX(), ImageOffsetY = b.getImageOffsetY(), BackgroundImagePath = background.getIconColored(), BackgroundText = background.getDescription(), Training = [], Effects = [] };

			local sparringPrice = Math.round(settlement.getSellPriceMult() * (80 + 50 * b.getLevel()));
			local veteranPrice = Math.round(settlement.getSellPriceMult() * (100 + 60 * b.getLevel()));
			local schoolingPrice = Math.round(settlement.getSellPriceMult() * (90 + 55 * b.getLevel()));

			if (World.Assets.getOrigin().getID() == "scenario.sato_men_at_arms")
			{
				sparringPrice = Math.round(sparringPrice * 0.5);
				veteranPrice = Math.round(veteranPrice * 0.5);
				schoolingPrice = Math.round(schoolingPrice * 0.5);
			}

			e.Training.push({ id = 0, icon = "skills/status_effect_75.png", name = "Sparring Fight", tooltip = "world-town-screen.training-dialog-module.Train1", price = sparringPrice });
			e.Training.push({ id = 1, icon = "skills/status_effect_76.png", name = "Veteran\'s Lessons", tooltip = "world-town-screen.training-dialog-module.Train2", price = veteranPrice });
			e.Training.push({ id = 2, icon = "skills/status_effect_77.png", name = "Rigorous Schooling", tooltip = "world-town-screen.training-dialog-module.Train3", price = schoolingPrice });
			roster.push(e);
		}

		return { Title = "Training Hall", SubTitle = "Have your men train for combat and learn from veterans", Roster = roster, Assets = m.Parent.queryAssetsInformation() };
	}

	ttdm.onTrain = function( _data ) {
		local entityID = _data[0];
		local trainingID = _data[1];
		local settlement = World.State.getCurrentTown();
		local entity = Tactical.getEntityByID(entityID);

		if (entity.getSkills().hasSkill("effects.trained"))
			return null;

		local price = 0;
		local effect = new("scripts/skills/effects_world/new_trained_effect");

		switch(trainingID)
		{
		case 0:
			price = Math.round(settlement.getSellPriceMult() * (80 + 50 * entity.getLevel()));
			effect.m.Duration = 1;
			effect.m.XPGainMult = 1.5;
			effect.m.Icon = "skills/status_effect_75.png";
			break;

		case 1:
			price = Math.round(settlement.getSellPriceMult() * (100 + 60 * entity.getLevel()));
			effect.m.Duration = 3;
			effect.m.XPGainMult = 1.35;
			effect.m.Icon = "skills/status_effect_76.png";
			break;

		case 2:
			price = Math.round(settlement.getSellPriceMult() * (90 + 55 * entity.getLevel()));
			effect.m.Duration = 5;
			effect.m.XPGainMult = 1.2;
			effect.m.Icon = "skills/status_effect_77.png";
			break;
		}

		if (World.Assets.getOrigin().getID() == "scenario.sato_men_at_arms")
			price = Math.round(price * 0.5);

		World.Assets.addMoney(-price);
		entity.getSkills().add(effect);
		local background = entity.getBackground();
		local e = { ID = entity.getID(), Name = entity.getName(), Level = entity.getLevel(), ImagePath = entity.getImagePath(), ImageOffsetX = entity.getImageOffsetX(), ImageOffsetY = entity.getImageOffsetY(), BackgroundImagePath = background.getIconColored(), BackgroundText = background.getDescription(), Training = [], Effects = [] };
		e.Effects.push({ id = effect.getID(), icon = effect.getIcon() });
		local r = { Entity = e, Assets = m.Parent.queryAssetsInformation() };
		return r;
	}
});
