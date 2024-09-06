/*
Minor visual tweaks for New Heads mod, targeted exclusively for New Balance mod.
- Nadja: restored original female body model and outfit
- Cassia: restored original female body model and outfit
- Lucia: uses new face to have a different one that Cassia and new outfit to have different one than Abigail, uses original body texture (skimpy fur, although in NB it looks different, but also interesting, so I decided to leave it like that)
- one guard in upper town got brand new face (to prevent conflict with Abigail from New Balance)
*/

META
{
    Parser = Game
    MergeMode = 1
};

instance VLK_435_NADJA(NPC_DEFAULT)
{
    VLK_435_NADJA_old();
    B_SetNpcVisual(VLK_435_Nadja, FEMALE, "Hum_Head_Babe", FACEBABE_N_HURE, BodyTexBabe_P, itar_vlkbabe_h); // change model
};

instance VLK_447_CASSIA(NPC_DEFAULT)
{
    VLK_447_CASSIA_old();
    B_SetNpcVisual(VLK_447_Cassia, FEMALE, "Hum_Head_Babe", FaceBabe_N_BlackHair, BodyTexBabe_N, itar_vlkbabe_h); // change body model and hair
};

instance BDT_1091_ADDON_LUCIA(NPC_DEFAULT)
{
	BDT_1091_ADDON_LUCIA_old();
	// use new face to have a different one than Cassia, don't use same armor as Abigail, use the original texture (skimpy fur)
	// old head: Hum_Head_Babe8 origin
	B_SETNPCVISUAL(BDT_1091_ADDON_LUCIA, FEMALE, "Hum_Head_Babe7", 167, 11, NO_ARMOR); // BODYTEXBABE_F looks different in NB, why?
};

instance Mil_307_Tuerwache(Npc_Default)
{
	Mil_307_Tuerwache_old();
	B_SetNpcVisual(self, MALE, "Hum_Head_Bald", 168, BodyTex_N, ITAR_MIL_M); // use new head to prevent conflict with Abigail from NB
};

func void EquipArmor (var C_NPC CURRENT_NPC, var C_NPC NPC, var INT ARMOR)
{
	// forces outfit change on already started game and makes sure it's done only when needed
	if(Hlp_GetInstanceID(NPC) == Hlp_GetInstanceID(CURRENT_NPC))
	{
		var c_item currentArmor; currentArmor = Npc_GetEquippedArmor(CURRENT_NPC);
		if(Hlp_GetInstanceID(currentArmor) != ARMOR)
		{
			if(!Npc_GetInvItem(CURRENT_NPC, ARMOR))
			{
				CreateInvItem(CURRENT_NPC, ARMOR);
			};
			AI_EquipArmor(CURRENT_NPC, ARMOR);
		};
	};
};

func void B_RefreshAtInsert()
{
	B_RefreshAtInsert_old();

	var C_NPC npcNadja; npcNadja = Hlp_GetNpc(VLK_435_NADJA);
	var C_NPC npcCassia; npcCassia = Hlp_GetNpc(VLK_447_CASSIA);
	var C_NPC npcLucia; npcLucia = Hlp_GetNpc(BDT_1091_ADDON_LUCIA);
	EquipArmor(self, npcNadja, itar_vlkbabe_h);
	EquipArmor(self, npcCassia, itar_vlkbabe_h);

	if (Hlp_GetInstanceID(npcLucia) == Hlp_GetInstanceID(self)) {
		AI_UnequipArmor(self);
	};
};
