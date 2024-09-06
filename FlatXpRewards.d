META
{
    Parser = Game
    MergeMode = TRUE
};

func void b_kapitelwechsel(var int neues_kapitel, var int aktuelles_level_zen) 
{
    B_Kapitelwechsel_old(neues_Kapitel, aktuelles_Level_Zen);

    if(KAPITEL == 1)
    {
        XP_AMBIENT = XP_AMBIENTKAP3;
    };
    if(KAPITEL == 2)
    {
        XP_AMBIENT = XP_AMBIENTKAP3;
    };
    
    if(KAPITEL == 4)
    {
        XP_AMBIENT = XP_AMBIENTKAP3;
    };
    if(KAPITEL == 5)
    {
        XP_AMBIENT = XP_AMBIENTKAP3;
    };
    if(KAPITEL == 6)
    {
        XP_AMBIENT = XP_AMBIENTKAP3;
    };
};
