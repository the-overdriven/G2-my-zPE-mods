/*
During a conversation with Vatras at the Adanos shrine in Khorinis or with Myxir at the excavation site, 
the Nameless Hero learns that the Water Mages are interested in ancient stone tablets 
that allow them to study the ancient culture of the Builders. The Hero decides to search for these artifacts 
scattered across the island and bring the tablets to Vatras for a reward.

In unmodded game, for each tablet given, the Nameless Hero receives a fixed amount of 30 xp 
and a reward that (unfortunately) depends on the number of tablets handed over at once:
- for 1-4 tablets – healing potions equal to: (the number of tablets given + 1);
- for 5-9 tablets – as many Fireball scrolls as the number of tablets given;
- for 10 or more tablets – as many maximum mana points as the number of tablets given.

With a total of 28 old tablets in the game, one can easily calculate it can boost your mana twice (20 tablets = 2 x 10 mana). 
The remaining 8 tablets can be spent on either one scroll and 4-6 potions, or 9-16 potions.

Problem is that the game doesn't inform the player about this reward mechanic whatsoever
and these tablets can be very easily wasted by giving them in suboptimal batches.

I.e. it never makes sense to give 2, 3 or 4 tablets at once, as it rewards you with 
3, 4 and 5 potions respectively. Whereas handing over 4 tablets 4 times separately (one by one) 
results in 8 potions.

Possible rewards combinations for collecting all tablets in umodded game:
- 35 potions, OR 56 potions if you give tablets one by one
- 25 scrolls and 4-6 potions
- 20 mana, 5 scrolls and 4-6 potions (most optimal but requires hoarding)
(and more combinations in between)

With my mod, after collecting all tablets, it ALWAYS rewards with: 18 mana + 5 scrolls + 4 potions. 
Important difference is that, unlike unmodded game, it doesn't require hoarding, so making up for it 
with a slightly smaller reward than in the unmodded game is only fair.

Ultimately, the rewards are the same whether you hand over tablets one by one, or every 4, 5, or 10 tablets. 
The mod counts the total number of tablets you have given and based on that grants different rewards, 
thanks to reward tiers. 

Initially, you receive potions; after giving 5 tablets, you start receiving scrolls; 
and finally, upon reaching 10 tablets, Vatras boosts your mana. 
Mana reward doesn't require hoarding a batch of min. 10 tablets (as in the original game), 
you just need to reach that final tier by giving 10 tablets, 
no matter if you give those 10 tablets all at once, or one by one.

Of course, nothing stops you from hoarding all the tablets to hand them all in at once, 
which will grant you all three reward types combined, as you retroactively receive rewards 
for the lower tiers. The total rewards in this case will still match those you would have received 
by giving the tablets one by one, which is: 4 potions, 5 scrolls, 18 mana.

In order to make it compatible with all language versions the script doesn't include this dialogue: 
"I have a stone tablet for you" / "Great! Take these elixirs/scrolls/etc." 
You've probably heard it a hundred times already, so it's not a big loss.
*/

META
{
    Parser = Game
    MergeMode = TRUE
};

var int stone_plates_given;

func int getBiggerInt(var int a, var int b) {
  if (a > b) {
    return a;
  }
  else {
    return b;
  };
};

func void stone_plates_reward(var int reward, var int anzahl) 
{
  var int rewardAmount; rewardAmount = getBiggerInt(anzahl, 1);

  if(reward == 1) {
    // 1-4
    b_giveinvitems(self,other,itpo_health_03,rewardAmount);
  }
  else if(reward == 2) {
    // 5-9
    b_giveinvitems(self,other,itsc_instantfireball,rewardAmount);
  }
  else if(reward == 3)
  {
    // 10+
    b_raiseattribute(other,ATR_MANA_MAX,rewardAmount);
    Npc_ChangeAttribute(other,ATR_MANA,rewardAmount);
  };
};

func void dia_addon_vatras_sellstonplate_info()
{
  var int anzahl;
  anzahl = Npc_HasItems(other,itwr_stoneplatecommon_addon);
  var int STONE_PLATES_GIVEN_prev;
  STONE_PLATES_GIVEN_prev = STONE_PLATES_GIVEN;

  b_giveinvitems(other,self,itwr_stoneplatecommon_addon,anzahl);
  
  STONE_PLATES_GIVEN = STONE_PLATES_GIVEN + anzahl;
  // Print(ConcatStrings("Stone plates given: ",IntToString(STONE_PLATES_GIVEN)));

  // give rewards depending on the threshold
  if(STONE_PLATES_GIVEN >= 10) {
    // 10+
    stone_plates_reward(3, STONE_PLATES_GIVEN - getBiggerInt(STONE_PLATES_GIVEN_prev, 10)); // 1-18 mana
  }
  else if(STONE_PLATES_GIVEN >= 5) {
    // 5-9
    stone_plates_reward(2, STONE_PLATES_GIVEN - getBiggerInt(STONE_PLATES_GIVEN_prev, 5)); // 1-5 scrolls
  }
  else {
    // 1-4
    stone_plates_reward(1, STONE_PLATES_GIVEN - STONE_PLATES_GIVEN_prev); // 1-4 potions
  };

  // give rewards for previous thresholds (happens only when reaching next threshold)
  if(STONE_PLATES_GIVEN_prev < 5 && STONE_PLATES_GIVEN >= 5 && STONE_PLATES_GIVEN < 10) {
    // from 1-4 to 5-9
    stone_plates_reward(1, 4 - STONE_PLATES_GIVEN_prev);
  }
  else if(STONE_PLATES_GIVEN_prev >= 5 && STONE_PLATES_GIVEN_prev < 10 && STONE_PLATES_GIVEN >= 10) {
    // from 5-9 to 10+
    stone_plates_reward(1, 4 - STONE_PLATES_GIVEN_prev);
  }
  else if(STONE_PLATES_GIVEN_prev < 5 && STONE_PLATES_GIVEN >= 10) {
    // from 1-4 to 10+
    stone_plates_reward(1, 4 - STONE_PLATES_GIVEN_prev);
    stone_plates_reward(2, 5);
  };

  b_giveplayerxp(XP_ADDON_VATRASSTONPLATE * anzahl);  
};
