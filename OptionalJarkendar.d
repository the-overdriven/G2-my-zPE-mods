META
{
    Parser = Game
    MergeMode = TRUE
};

// dialog: "oko Innosa zostalo zniszczone"
func int dia_vatras_innoseyekaputt_condition()
{
    if((Npc_HasItems(other,itmi_innoseye_broken_mis) || (MIS_SCKNOWSINNOSEYEISBROKEN == TRUE)) && (KAPITEL == 3))
    {
        return TRUE;
    };
};

// dialog: "mam pewien problem z okiem Innosa" - "a bede musial w tym celu opuscic miasto?"
func int dia_addon_vatras_abloesepre_condition()
{
  return FALSE;
};

// dialog: "przybyl zmiennik"
func int dia_addon_vatras_addonsolved_condition()
{
  return FALSE;
};
