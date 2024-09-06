/*
Makes your playthrough more free by not forcing you to complete Night of the Raven addon content in Jarkendar (original/German: Jharkendar).

Normally, in order to progress with the main quest, one has to complete Jarkendar between the beginning of chapter 2 (after talking to Lord Hagen)
and the end of chapter 3 (before repairing the Eye of Innos). In other words, you have to kill Raven to advance to chapter 4 
and there's just no way around it.

With this mod, Vatras no longer requires a replacement, allowing him to initiate the Eye repair ritual 
without the player ever setting a foot in Jarkendar. Which means, you can skip Jarkendar in your playthrough entirely, 
or enter it later: in chapter 4, or 5.

If Jarkendar isn’t your cup of tea, this offers yet another way to skip its content without resorting to overkill solutions 
such as searching high and low for addon-less version of the game, or installing the Classic mod (or similar), 
which throws the good out with the bad by removing the whole NotR addon content: not only Jarkendar, 
but also Khorinis world changes, items, monsters (goodbye boars), skills, balance changes, etc.

If you change your mind mid-game, Jarkendar is still an option - you can still enter it, but you’re not compelled to. 
Play differently than before, mix things up and pay dragons a visit before dealing with Raven. Up for a challenge?

Keep in mind that, like other worlds, Jarkendar continues to spawn new monsters with each new chapter, even after the third chapter. 
Clearing it later than designed, from all monsters at once, can be still challenging late game.
*/

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
