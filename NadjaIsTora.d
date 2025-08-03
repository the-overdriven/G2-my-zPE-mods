/*
  Nadja Is Thora
  Changes Nadja to look like Thora (Tora) from Gothic Sequel
  and adds some random animations to her routines.
*/

META
{
  Parser = Game
  MergeMode = 1
};

class C_Trigger
{
  var int Delay;
  var int Enabled;
  var int AIVariables[16];
};

var C_Trigger NadjaTrigger;

func void nadja_trigger() {
   // var C_Trigger trigger;
   NadjaTrigger = AI_StartTriggerScriptEx("nadja_loop", 1000, hero, null, null);
   NadjaTrigger.AIVariables[0] = 50; // how many times the function should be called
   NadjaTrigger.Delay = 500;         // repeat loop each call by 500ms (default: 200 ms)
   NadjaTrigger.AIVariables[1] = 1;  // foolery type. 1=dance, 2=foolery
   // Hlp_PrintConsole("trigger started");
};

func int nadja_loop()
{

  if(Wld_IsTime(16,0,04,59) == 0)
  {
    // foolery happens only between 4pm and 5am
    return 0;
  };

  var int distToNadja; distToNadja = Npc_GetDistToWP(self, "NW_PUFF_DANCE");

  if(distToNadja > 6000)
  {
    // must be greater than rendering range
    NadjaTrigger.Enabled = 0;
  };

  // Create a loop end check, if the number of
  // available iterations has reached below 0. If it did
  // we reset the animation and restart the trigger
  if (NadjaTrigger.AIVariables[0] < 0)
  {
    // Hlp_PrintConsole("trigger loop finished, Nadja move on to next animation");
    var C_NPC Nadja; Nadja = Hlp_GetNpc(VLK_435_NADJA);

    // reset ongoing animation
    Npc_PlayAni(Nadja, "T_WALKSTRAFEL");
    Npc_StopAni(Nadja, "T_WALKSTRAFEL");
    NadjaTrigger.AIVariables[0] = 50;
  };

  NadjaTrigger.AIVariables[0] -= 1; // Reduce number of remaining repeats

  return LOOP_CONTINUE;
};

instance VLK_435_NADJA(NPC_DEFAULT)
{
  // ------ NSC ------
  name    = "Nadja";  
  guild   = GIL_VLK;
  id      = 435;
  voice   = 16;
  flags   = 0;                                
  npctype = NPCTYPE_MAIN;
  
  //-----------AIVARS----------------
  aivar[AIV_ToughGuy] = TRUE; 
  
  // ------ Attribute ------
  B_SetAttributesToChapter (self, 1);                               
    
  // ------ Kampf-Taktik ------
  fight_tactic    = FAI_HUMAN_COWARD;
  
  // ------ Inventory ------
  B_CreateAmbientInv  (self);
    
  // ------ visuals ------                                      
  //B_SetNpcVisual    (self, FEMALE, "Hum_Head_Babe8", FaceBabe_N_Hure, BodyTex_N, ITAR_VlkBabe_H); 
  //Mdl_SetModelFatness (self,0);
  //Mdl_ApplyOverlayMds (self, "Humans_Babe.mds"); 
  mdl_setvisual(self, "AML.MDS"); // why it includes AML_BOWT1.MDS and AML_CBOWT1.MDS ??
  mdl_setvisualbody(self, "AML_Body_Naked0", 4, 4, "Bab_Head_Amazone", 0, default, -1);
  
  // ------ NSC-relevante Talente vergeben ------
  B_GiveNpcTalents (self);
  
  // ------ Kampf-Talente ------                                  
  B_SetFightSkills (self, 30); 

  // ------ TA anmelden ------
  daily_routine = Rtn_Nadja_435;
};

func void B_RefreshAtInsert()
{
  B_RefreshAtInsert_old();

  var C_NPC npcNadja; npcNadja = Hlp_GetNpc(VLK_435_NADJA);

  if (Hlp_GetInstanceID(npcNadja) == Hlp_GetInstanceID(self)) {
    nadja_trigger(); // do it once, only when Nadja is rendered
  };
};

func void ZS_Tora_Smoke()
{
  Perception_Set_Normal();
  
  B_ResetAll (self);
  
  AI_SetWalkmode  (self,NPC_WALK);
  
  // if (Npc_GetDistToWP (self,self.wp) > TA_DIST_SELFWP_MAX) 
  // {
  //   AI_GotoWP (self, self.wp);
  // };
  
  if (Npc_HasItems (self,ItMi_Joint) == 0)
  {
    CreateInvItem (self,ItMi_Joint);        
  };
  self.aivar[AIV_TAPOSITION] = NOTINPOS;
};

func int ZS_Tora_Smoke_loop()
{
  if (Npc_IsOnFP (self,"STAND"))
  {
    Ai_AlignToFP (self);
    if (self.aivar[AIV_TAPOSITION] == NOTINPOS_WALK)
      {
        self.aivar[AIV_TAPOSITION] = NOTINPOS;
      };
  } 
  else if (Wld_IsFPAvailable(self,"STAND"))
  {
    AI_GotoFP     (self, "STAND");
    AI_StandUp    (self);
    AI_AlignToFP  (self);
    self.aivar[AIV_TAPOSITION] = NOTINPOS_WALK;
  }
  else
  {
    AI_AlignToWP (self);
    if (self.aivar[AIV_TAPOSITION] == NOTINPOS_WALK)
      {
        self.aivar[AIV_TAPOSITION] = NOTINPOS;
      };
  };
  
  if (self.aivar[AIV_TAPOSITION] == NOTINPOS)
  {
    AI_UseItemToState   (self,ItMi_JOINT,0);
    self.aivar[AIV_TAPOSITION] = ISINPOS;
  };      

//*********************************************************
//  Hier: RandomAnis
//********************************************************

  var int stateTime; stateTime = Npc_GetStateTime(self);

  if ((Npc_GetStateTime(self) > 5)
  && (self.aivar[AIV_TAPOSITION] == ISINPOS))
  {
    Npc_PlayAni(self, "T_JOINT_RANDOM_1"); // stand only

    if (Npc_GetStateTime(self) > 10)
    {
      AI_PlayAniBS (self,"T_JOINT_S0_2_STAND",BS_ITEMINTERACT); // smoke with puff
      Npc_PlayAni(self, "T_JOINT_S0_2_STAND");
      Npc_SetStateTime (self, 0);
    };
  };
  
  return LOOP_CONTINUE;
};

func void ZS_Tora_Smoke_end()
{
  AI_UseItemToState (self, ItMi_Joint, -1);
};

func void TA_Tora_Smoke (var int start_h, var int start_m, var int stop_h, var int stop_m, VAR string waypoint) {TA_Min   (self,  start_h,start_m, stop_h, stop_m, ZS_Tora_Smoke, waypoint);};
func void TA_TorasFoolery (var int start_h, var int start_m, var int stop_h, var int stop_m, VAR string waypoint) {TA_Min (self, start_h,start_m, stop_h, stop_m, zs_TorasFoolery, waypoint); };
func void TA_ToraSleepOnFloorOrBrush (var int start_h, var int start_m, var int stop_h, var int stop_m, VAR string waypoint)  {TA_Min (self, start_h,start_m, stop_h, stop_m, zs_ToraSleepOnFloorOrBrush, waypoint); };

func void zs_ToraSleepOnFloorOrBrush()
{
  perception_set_normal();
  b_resetall(self);
  AI_SetWalkMode(self,NPC_WALK);
  AI_SetWalkMode(VLK_435_Nadja,NPC_WALK);
  if(Npc_GetDistToWP(self,self.wp) > TA_DIST_SELFWP_MAX)
  {
    AI_GotoWP(self,self.wp);
    AI_AlignToWP(self);
  };
};

func int zs_ToraSleepOnFloorOrBrush_Loop()
{
  var int rand; rand = Hlp_Random(2);

  // Hlp_PrintConsole(Str_format("zs_ToraSleepOnFloorOrBrush_Loop rand: %i", rand));

  if(Wld_IsTime(05,0,09,00) == 1)
  {
    AI_PlayAni(self, "S_DEADB");
  }
  else
  {
    if (rand == 1) {
      mdl_setvisualbody(VLK_435_Nadja, "AML_Body_Naked0", 0, 0, "Bab_Head_Amazone", 0, default, -1); // work clothes

      // will always end at 1, interesting
      // some state animations stop the loop
      AI_PlayAni(self, "T_WOUNDED_2_STAND_B");
      AI_PlayAni(self, "S_BRUSH_S1");
    };
  };

  return LOOP_CONTINUE;
};

func int zs_ToraSleepOnFloorOrBrush_End()
{
  // Hlp_PrintConsole("zs_ToraSleepOnFloorOrBrush_End");
  perception_set_normal();
  b_resetall(self);
  AI_PlayAni(self, "T_WOUNDED_2_STAND_B");
  // TODO: reset animation before moving to next routine
};

func void zs_TorasFoolery()
{
  mdl_setvisualbody(VLK_435_Nadja, "AML_Body_Naked0", 0, 4, "Bab_Head_Amazone", 0, default, -1); // dance clothes
  
  perception_set_normal();
  b_resetall(self);
  AI_SetWalkMode(self,NPC_WALK);
  AI_SetWalkMode(VLK_435_Nadja,NPC_WALK);

  if(Npc_GetDistToWP(self,self.wp) > TA_DIST_SELFWP_MAX)
  {
    AI_GotoWP(self,self.wp);
    AI_AlignToWP(self);
  };

  NadjaTrigger.AIVariables[0] = 50;
  // Hlp_PrintConsole("zs_TorasFoolery, timer set to 50");
  
  NadjaTrigger.AIVariables[1] = 0;
};

func int zs_TorasFoolery_Loop()
{
  AI_SetWalkMode(VLK_435_Nadja,NPC_WALK);

  var int fooleryType; fooleryType = NadjaTrigger.AIVariables[1];
  if (NadjaTrigger.AIVariables[0] < 25 || fooleryType <= 1) {    
    // wait some time before starting next animation
    var int randomAnimation;
    randomAnimation = Hlp_Random(53);

    // Hlp_PrintConsole(Str_format("randomAnimation: %i (28+ = dance) ", randomAnimation));

    if (randomAnimation == NadjaTrigger.AIVariables[2]) {
      // do not repeat the same animation
      // TODO: it won't work as expected since random range was increased
      return LOOP_CONTINUE;
    };

    var int distToWp; distToWp = Npc_GetDistToWP(self, self.wp);
    if (distToWp > 400 || randomAnimation >= 28) {
      // go back to home waypoint
      AI_SetWalkMode(self, NPC_WALK);
      AI_GotoWP(self, self.wp);
      AI_AlignToWP(self);
      AI_SetWalkMode(VLK_435_Nadja,NPC_WALK);
    };

    Mdl_StartFaceAni(self,"S_NEUTRAL",1,-1);

    if ( randomAnimation >= 52 )
    {
      // NadjaTrigger.AIVariables[0] = 110;
      NadjaTrigger.AIVariables[1] = 1;
      AI_PlayAni(self, "S_DANCE1");
    }
    else if ( randomAnimation >= 50 )
    {
      // NadjaTrigger.AIVariables[0] = 110;
      NadjaTrigger.AIVariables[1] = 1;
      AI_PlayAni(self, "S_DANCE2");
    }
    else if ( randomAnimation >= 48 )
    {
      // NadjaTrigger.AIVariables[0] = 110;
      NadjaTrigger.AIVariables[1] = 1;
      AI_PlayAni(self, "S_DANCE3");
    }
    else if ( randomAnimation >= 46 )
    {
      // NadjaTrigger.AIVariables[0] = 110;
      NadjaTrigger.AIVariables[1] = 1;
      AI_PlayAni(self, "S_DANCE4");
    }
    else if ( randomAnimation >= 44 )
    {
      // NadjaTrigger.AIVariables[0] = 110;
      NadjaTrigger.AIVariables[1] = 1;
      AI_PlayAni(self, "S_DANCE5");
    }
    else if ( randomAnimation >= 42 )
    {
      // NadjaTrigger.AIVariables[0] = 110;
      NadjaTrigger.AIVariables[1] = 1;
      AI_PlayAni(self, "S_DANCE6");
    }
    else if ( randomAnimation >= 40 )
    {
      // NadjaTrigger.AIVariables[0] = 110;
      NadjaTrigger.AIVariables[1] = 1;
      AI_PlayAni(self, "S_DANCE7");
    }
    else if ( randomAnimation >= 38 )
    {
      // NadjaTrigger.AIVariables[0] = 110;
      NadjaTrigger.AIVariables[1] = 1;
      AI_PlayAni(self, "S_DANCE8");
    }
    else if ( randomAnimation >= 36 )
    {
      // NadjaTrigger.AIVariables[0] = 110;
      NadjaTrigger.AIVariables[1] = 1;
      AI_PlayAni(self, "S_DANCE9");
    }
    else if ( randomAnimation >= 34 )
    {
      // NadjaTrigger.AIVariables[0] = 110;
      NadjaTrigger.AIVariables[1] = 1;
      AI_PlayAni(self, "S_DANCE10");
    }
    else if ( randomAnimation >= 32 )
    {
      // NadjaTrigger.AIVariables[0] = 110;
      NadjaTrigger.AIVariables[1] = 1;
      AI_PlayAni(self, "S_DANCE11");
    }
    else if ( randomAnimation >= 30 )
    {
      // NadjaTrigger.AIVariables[0] = 110;
      NadjaTrigger.AIVariables[1] = 1;
      AI_PlayAni(self, "S_DANCE12");
    }
    else if ( randomAnimation >= 28 )
    {
      // NadjaTrigger.AIVariables[0] = 110;
      NadjaTrigger.AIVariables[1] = 1;
      AI_PlayAni(self, "S_DANCE13");
    };
    
    if (NadjaTrigger.AIVariables[2] >= 28 ) {
      // do it only if previous animation was a dance (favor dance more often)
      if ( randomAnimation >= 26)
      {
        NadjaTrigger.AIVariables[0] = 50;
        AI_PlayAni(self, "S_CHESTBIG_S0");
        NadjaTrigger.AIVariables[1] = 2;
      }
      else if ( randomAnimation >= 25)
      {
        NadjaTrigger.AIVariables[0] = 20;
        AI_PlayAni(self, "T_SEARCH");
        AI_PlayAni(self, "C_LOOK_2");
        NadjaTrigger.AIVariables[1] = 2;
      }
      else if ( randomAnimation >= 24)
      {
        NadjaTrigger.AIVariables[0] = 50;
        AI_PlayAni(self, "T_NO");
        AI_PlayAni(self, "C_LOOK_2");
        AI_PlayAni(self, "T_NO");
        NadjaTrigger.AIVariables[1] = 2;
      }
      else if ( randomAnimation >= 23)
      {
        // Hlp_PrintConsole("T_MDT_S0_2_S1");

        NadjaTrigger.AIVariables[0] = 120;
        Mdl_StartFaceAni(self,"S_NEUTRAL",1,-1);
        AI_PlayAni(self, "T_MDT_S0_2_S1");
        Mdl_StartFaceAni(self,"S_NEUTRAL",1,-1);
        NadjaTrigger.AIVariables[1] = 2;
        NadjaTrigger.AIVariables[0] = 120;
      }
      else if ( randomAnimation >= 19)
      {
        // Hlp_PrintConsole("T_CON_VICTIM");

        NadjaTrigger.AIVariables[0] = 50;
        AI_PlayAni(self, "T_CON_VICTIM");
        AI_PlayAni(self, "S_CON_VICTIM");
        NadjaTrigger.AIVariables[1] = 2;
      }
      else if ( randomAnimation >= 18)
      {
        NadjaTrigger.AIVariables[0] = 100;
        // AI_PlayAni(self, "T_1HPARADEJUMPB");
        AI_PlayAni(self, "T_DEADB");
        AI_PlayAni(self, "S_DEADB");
        NadjaTrigger.AIVariables[1] = 2;
      }
      else if ( randomAnimation >= 17)
      {
        NadjaTrigger.AIVariables[0] = 100;
        AI_PlayAni(self, "T_FISTPARADEJUMPB");
        AI_PlayAni(self, "T_DEADB");
        AI_PlayAni(self, "S_DEADB");
        NadjaTrigger.AIVariables[1] = 2;
      }
      else if ( randomAnimation >= 16)
      {
        NadjaTrigger.AIVariables[0] = 50;
        AI_PlayAni(self, "T_PSI_VICTIM");
        AI_PlayAni(self, "S_PSI_VICTIM");
        NadjaTrigger.AIVariables[1] = 2;
      }
      else if ( randomAnimation >= 15)
      {
        NadjaTrigger.AIVariables[0] = 50;
        AI_PlayAni(self, "S_CONSHOOT");
        NadjaTrigger.AIVariables[1] = 2;
      }
      else if ( randomAnimation >= 14)
      {
        NadjaTrigger.AIVariables[0] = 50;
        AI_PlayAni(self, "T_FISTPARADEJUMPB");
        NadjaTrigger.AIVariables[1] = 2;
      };
    };

    if ( randomAnimation >= 8 )
    { // 8-13
      if (NadjaTrigger.AIVariables[2] < 8 || NadjaTrigger.AIVariables[2] > 13)
      {
        NadjaTrigger.AIVariables[0] = 40;

        AI_SetWalkMode(VLK_435_Nadja,NPC_WALK);
        AI_GotoWP(self,"NW_CITY_HABOUR_PUFF_IN_01");
        AI_PlayAni(self, "T_FISTPARADEJUMPB");
        AI_PlayAni(self, "T_FISTPARADEJUMPB");
      };
    }
    else if ( randomAnimation >= 5 )
    {
      // Hlp_PrintConsole("drink time");

      NadjaTrigger.AIVariables[0] = 90;

      CreateInvItem (self,itfo_booze);
      AI_UseItemToState (self,itfo_booze,0);
      Npc_PlayAni (self,"T_POTION_RANDOM_1");

      // TODO: fix: if joint animation happens after drinking it gets stuck or item disappears

      NadjaTrigger.AIVariables[1] = 2;
    }
    else
    {
      NadjaTrigger.AIVariables[1] = 2;
      NadjaTrigger.AIVariables[0] = 100;

      CreateInvItem (self,ItMi_Joint);   
      AI_UseItemToState   (self,ItMi_JOINT,0);     
      AI_PlayAniBS (self,"T_JOINT_S0_2_STAND",BS_ITEMINTERACT); // with puff

      // Hlp_PrintConsole("joint time");
      Mdl_StartFaceAni(self,"S_FRIENDLY",1,-1);
    };

    NadjaTrigger.AIVariables[2] = randomAnimation;

    return LOOP_CONTINUE;
  };
};

FUNC VOID Rtn_Nadja_435 ()
{
  ta_ToraSleepOnFloorOrBrush(05,01,11,0,"NW_PUFF_DANCE");
  ta_Tora_Smoke(11,01,13,0,"NW_PUFF_DANCE");
  ta_smoke_waterpipe(13,01,16,00,"NW_PUFF_DANCE");
  ta_TorasFoolery(16,01,05,00,"NW_PUFF_DANCE");
};  

// ---------
// dialogues

func void dia_nadja_hochgehen_info()
{
  Mdl_StartFaceAni(VLK_435_Nadja,"S_FRIENDLY",1,-1);
  mdl_setvisualbody(VLK_435_Nadja, "AML_Body_Naked0", 1, 4, "Bab_Head_Amazone", 0, default, -1); // naughty clothes

  dia_nadja_hochgehen_info_old();

  AI_SetWalkMode(VLK_435_Nadja,NPC_WALK);
};

func void dia_nadja_danach_info()
{
  dia_nadja_danach_info_old();

  Mdl_StartFaceAni(VLK_435_Nadja,"S_FRIENDLY",1,-1);
  mdl_setvisualbody(VLK_435_Nadja, "AML_Body_Naked0", 4, 4, "Bab_Head_Amazone", 0, default, -1); // dance clothes

  Npc_ExchangeRoutine(VLK_435_Nadja,"Nadja");

  AI_SetWalkMode(VLK_435_Nadja,NPC_WALK);
};

func int dia_nadja_danach_condition()
{
  // fix for dialogue not triggering
  if((BROMOR_PAY == FALSE) && (NADJA_NACHT == TRUE))
  {
    return TRUE;
  };
};
