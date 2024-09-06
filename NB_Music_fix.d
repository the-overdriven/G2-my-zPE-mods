/*
For New Balance mod only.
Restores Monastery and Pyramid original theme that was removed in New Balance.
*/

META
{
    Parser = Music
    MergeMode = TRUE
};

instance NWP_DAY_STD(C_MUSICTHEME_STANDARD)
{
	// New World Pyramids
	// Returning: "Keeper_library.sgt"
	file = "MI_DayStd.sgt";
};

instance MOD_NGT_STD(C_MUSICTHEME_STANDARD)
{
	// New World Monastery Indoor
	// Returning: "ban_daystd.sgt";
	file = "MI_DayStd.sgt";
};

instance MOD_DAY_STD(C_MUSICTHEME_STANDARD)
{
	// New World Monastery Indoor
	// Returning: "ban_daystd.sgt";
	file = "MI_DayStd.sgt";
};
