/*
Prevents loosing XP due to NPC stealing your kill. If a monster is killed by NPC or other monster, 
it collapses instead of dying, so that you can finish it off and earn the XP that would otherwise be lost.
*/

META
{
    Parser = Game
    MergeMode = TRUE
};

func int isMonster(var C_NPC npc)
{
    if (npc.guild > GIL_SEPERATOR_HUM) {
        return TRUE;
    };

    return FALSE;
};

func void animateDead(var C_NPC npc)
{
    var int rnd; rnd = Hlp_Random(2);
    if (npc.aivar[AIV_INVINCIBLE] == FALSE) {

        if (rnd == 0) {
            AI_PlayAni(npc,"T_DEAD");
        };
        if (rnd == 1) {
            AI_PlayAni(npc,"T_DEADB");
        };

        npc.aivar[AIV_INVINCIBLE] = TRUE;
    };

    if (npc.aivar[AIV_INVINCIBLE] == TRUE) {
         if (rnd == 0) {
            AI_PlayAni(npc,"S_DEAD");
        };
        if (rnd == 1) {
            AI_PlayAni(npc,"S_DEADB");
        };
    };
};

func int dropDeadIfOneHP(var C_NPC slf, var C_NPC oth)
{
    // monster is attacked
    if (isMonster(oth) && oth.attribute[ATR_HITPOINTS] == 1) {
        animateDead(oth);
        return TRUE;
    };

    // monster is attacker
    if (isMonster(slf) && slf.attribute[ATR_HITPOINTS] == 1) {
        animateDead(slf);
        return TRUE;
    };

    return FALSE;
};

func int C_DropUnconscious()
{
    // self = victim, other = winner
    if (isMonster(self) && (Npc_IsPlayer(other) || other.aivar[AIV_PARTYMEMBER])) {
        // hero and his bros kill monsters always

        self.aivar[AIV_INVINCIBLE] = FALSE;
        return FALSE;
    };

    if (isMonster(self) && !Npc_IsPlayer(other)) {
        // NPC do not kill monsters

        if (self.attribute[ATR_HITPOINTS] < 1) {
            self.attribute[ATR_HITPOINTS] = 1;
        };

        return FALSE;
    };

    C_DropUnconscious_old();
};

func int zs_attack_loop()
{
    if(dropDeadIfOneHP(self, other))
    {
        return LOOP_END;
    };

    zs_attack_loop_old();
};

func int zs_mm_attack_loop()
{
    if(dropDeadIfOneHP(self, other))
    {
        return LOOP_END;
    };
    zs_mm_attack_loop_old();
};

func void b_attack(var C_NPC slf,var C_NPC oth,var int attack_reason,var int wait)
{
    if(dropDeadIfOneHP(slf, oth))
    {
        return;
    };

    b_attack_old(slf, oth, attack_reason, wait);
};

func void b_refreshatinsert()
{
    if(dropDeadIfOneHP(self, other))
    {
        return;
    };

    b_refreshatinsert_old();
};

func void zs_mm_allscheduler()
{
    // prevent overwriting "fake death" state
    self.aivar[AIV_MM_PRIORITY] = PRIO_EAT;
    if((self.guild == GIL_STONEGUARDIAN) && (RAVENISDEAD == TRUE))
    {
        b_killnpc(self);
    };
    if(Wld_IsTime(self.aivar[AIV_MM_SLEEPSTART],0,self.aivar[AIV_MM_SLEEPEND],0) || (self.aivar[AIV_MM_SLEEPSTART] == ONLYROUTINE))
    {
        if(dropDeadIfOneHP(self, other) == FALSE) {
            AI_StartState(self,zs_mm_rtn_sleep,1,"");
        };
    }
    else if(Wld_IsTime(self.aivar[AIV_MM_RESTSTART],0,self.aivar[AIV_MM_RESTEND],0) || (self.aivar[AIV_MM_RESTSTART] == ONLYROUTINE))
    {
        if(dropDeadIfOneHP(self, other) == FALSE) {
            AI_StartState(self,zs_mm_rtn_rest,1,"");
        };
    }
    else if(Wld_IsTime(self.aivar[AIV_MM_ROAMSTART],0,self.aivar[AIV_MM_ROAMEND],0) || (self.aivar[AIV_MM_ROAMSTART] == ONLYROUTINE))
    {
        if(dropDeadIfOneHP(self, other) == FALSE) {
            AI_StartState(self,zs_mm_rtn_roam,1,"");
        };
    }
    else if(Wld_IsTime(self.aivar[AIV_MM_EATGROUNDSTART],0,self.aivar[AIV_MM_EATGROUNDEND],0) || (self.aivar[AIV_MM_EATGROUNDSTART] == ONLYROUTINE))
    {
        if(dropDeadIfOneHP(self, other) == FALSE) {
            AI_StartState(self,zs_mm_rtn_eatground,1,"");
        };
    }
    else if(Wld_IsTime(self.aivar[AIV_MM_WUSELSTART],0,self.aivar[AIV_MM_WUSELEND],0) || (self.aivar[AIV_MM_WUSELSTART] == ONLYROUTINE))
    {
        if(dropDeadIfOneHP(self, other) == FALSE) {
            AI_StartState(self,zs_mm_rtn_wusel,1,"");
        };
    }
    else if(Wld_IsTime(self.aivar[AIV_MM_ORCSITSTART],0,self.aivar[AIV_MM_ORCSITEND],0) || (self.aivar[AIV_MM_ORCSITSTART] == ONLYROUTINE))
    {
        if(dropDeadIfOneHP(self, other) == FALSE) {
            AI_StartState(self,zs_mm_rtn_orcsit,1,"");
        };
    }
    else
    {
        if(dropDeadIfOneHP(self, other) == FALSE) {
            AI_StartState(self,zs_mm_rtn_rest,1,"");
        };
    };
};
