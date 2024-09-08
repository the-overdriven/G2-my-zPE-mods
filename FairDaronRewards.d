/*
In unmodded game, you can donate a total of 1000 gold to Daron, 
but it doesn't make sense to donate more than 50 gold at once, 
as you'll reach the limit sooner and the reward for each donation 
is the same regardless of the gold given at one time anyway.

My script alteration makes Daron rewards more fair:
- Donating 200 gold rewards the same as donating 50 gold four times.
- Donating 100 gold rewards the same as donating 50 gold twice.

Now you can try out suboptimal donation options without worry and hear different responses. 
Let Innos light shine upon you.
*/

META
{
    Parser = Game
    MergeMode = TRUE
};

var int daron_spende_now;

func void b_daronsegen()
{
    daron_spende_now = daron_spende_now - 50;

    b_daronsegen_old();

    if (daron_spende_now > 0) {
        // print messages

        var string rewardMsg; rewardMsg = Par_GetSymbolValueString(
            Par_GetParserID("Game"), 
            Par_GetSymbolID(
                Par_GetParserID("Game"), 
                "b_daronsegen_old.concattext"
            )
        );
        
        if (daron_spende_now == 150) {
            PrintScreen(rewardMsg,-1,39,FONT_SCREEN,2);
        } else if (daron_spende_now == 100) {
            PrintScreen(rewardMsg,-1,42,FONT_SCREEN,2);
        } else if (daron_spende_now == 50) {
            PrintScreen(rewardMsg,-1,45,FONT_SCREEN,2);
        };

        b_daronsegen();
    };
};

func void dia_daron_spende_50()
{
    daron_spende_now = 50;
    dia_daron_spende_50_old();
};
func void dia_daron_spende_100()
{
    daron_spende_now = 100;
    dia_daron_spende_100_old();
};
func void dia_daron_spende_200()
{
    daron_spende_now = 200;
    dia_daron_spende_200_old();
};
