/*
In Gothic 2, certain quests reward the player with experience points (XP) 
determined by a variable called "XP_AMBIENT". 
The value of this variable depends on the current chapter of the game:
Chapter 1: 50xp
Chapter 2: 100xp
Chapter 3: 150xp
Chapter 4: 200xp
Chapter 5: 250xp
Chapter 6: 300xp

Although many quests that derive its XP reward from this variable can only 
be completed in specific chapters (resulting in a fixed XP reward), 
some quests and actions can be strategically delayed until later chapters for more XP. 
For example, drinking potion of mental alteration 
would reward you with a whooping 1250xp in chapter 5, but merely 500xp in chapter 2.

This mod flattens XP_AMBIENT value to be always the same (150xp, as if it's Chapter 3), 
so that you don't have to worry that you're missing out 
when playing the game in "incorrect" order, because of not min-maxing the rewards.

As a side effect, when playing in a completionist way, it makes the early game 
(before chapter 3) slightly easier due to quicker progress, 
but it also slows down progress in the late game (chapter 4-6). 
Meaning that i.e. all actions that normally give 50xp in chapter 1 will give now 150xp.
On the other hand, quests in chapter 5 that used to give 250xp will have their rewards decreased to 150xp. 
It shouldn't affect xp rewards in chapter 3.

As a result, killing monsters in the late game should be more worthwhile than quests now, 
whereas in the early game other way around: completing quests will be more rewarding.
Which is what most players do anyway, 
since most monsters are too strong for us at the beginning of the game.

Complete list of affected functions/dialogues:
- useitpo_geist_02()
- usebloodmis()
- b_assignorc_antipaladintalk()
- raketreasuresuccess()
- use_bookstandmaya()
- use_bookstandmayahierchary_01_s1()
- pc_prayshrine_healshrine_info()
- dia_addon_cavalorn_pickpocket_doit()
- dia_addon_cavalorn_beutel_info()
- dia_addon_cavalorn_broughtletter_info()
- dia_addon_cavalorn_gotornafromhagen_info()
- dia_elena_minenanteil_info()
- dia_sekob_rosibackatsekob_info()
- dia_sekob_rosineverback_info()
- dia_addon_balthasar_rangerbandits_info()
- dia_bronko_keinbauer_sld()
- dia_rosi_fleefromsekob_info()
- dia_rosi_angekommen_info()
- dia_rosi_trait_info()
- dia_rosi_minenanteil_info()
- dia_akil_nachkampf_info()
- dia_addon_akil_missingpeople_info()
- dia_addon_akil_returnpeople_info()
- dia_lobart_vinotot_info()
- dia_hilda_bringbeet_info()
- dia_vino_perm4obsessed_info()
- dia_addon_bengar_missingpeople_info()
- dia_addon_bengar_returnpardos_info()
- dia_addon_bengar_fernandosweapons_info()
- dia_bengar_balthasar_info()
- dia_bengar_balthasardarfaufweide_info()
- dia_addon_gaan_ranger_info()
- dia_addon_orlan_ranger_aqua()
- dia_addon_orlan_teleportstein_info()
- dia_addon_orlan_whenrangermeeting_info()
- dia_orlan_wettkampflaeuft_info()
- dia_orlan_minenanteil_info()
- dia_rukhar_ichsehedich_info()
- dia_grom_payteacher_info()
- dia_grimbald_novchase_info()
- dia_grimbald_trolltot_info()
- dia_addon_finn_ein_info()
- dia_addon_thorus_sent_info()
- dia_addon_garaz_blood_info()
- dia_dexter_hallo_info()
- dia_addon_dexter_greg_info()
- dia_addon_tom_dead_info()
- dia_addon_scatty_bier_info()
- dia_addon_lucia_khorinis_info()
- dia_franco_pickpocket_doit()
- dia_addon_fisk_sieg_info()
- dia_sylviodjg_whatnext_info()
- dia_angar_di_orks_follow()
- dia_angar_di_follow_info()
- dia_biff_di_orks_info()
- dia_schwarzmagier_hello_schlaefer()
- dia_pyrokar_foundinnoseye_info()
- dia_pyrokar_spoketovatras_info()
- dia_pyrokar_kap3_ready_info()
- dia_pyrokar_buchderbessenen_info()
- dia_pyrokar_irdorathbookopen_glueck()
- dia_pyrokar_irdorathbookopen_xardas()
- dia_serpentes_gotsalandril_info()
- dia_serpentes_salandrildead_info()
- dia_karras_innoseyeretrieved_info()
- dia_karras_itam_prot_blackeye_mis_info()
- dia_isgaroth_vatras_info()
- dia_addon_saturas_flut_info()
- dia_addon_saturas_raveninfos_info()
- dia_addon_saturas_openportal_info()
- dia_addon_myxir_city_hellocity_info()
- dia_addon_merdarion_teleportsteinsuccess_info()
- dia_mil_310_stadtwache_zumschmied_info()
- dia_mika_hilfe_akil()
- dia_mil_310_stadtwache_zumschmied_info()
- dia_mika_hilfe_akil()
- dia_mika_wiedernachhause_info()
- dia_addon_xardas_stoneplate_info()
- dia_addon_xardas_addonsuccess_info()
- dia_xardas_aboutlester_info()
- dia_xardas_backfromow_info()
- dia_xardas_dmtsindda_beweis()
- dia_xardas_innoseyebroken_info()
- dia_xardas_ritualrequest_info()
- dia_xardas_bereit_info()
- dia_pedro_di_perm_info()
- dia_dyrian_helloagain_info()
- dia_opolos_rezept_info()
- dia_opolos_helloagain_info()
- dia_opolos_kap3_perm_dragons()
- dia_opolos_kap3_perm_dmt()
- dia_opolos_kap3_perm_pedro()
- dia_babo_sergio_info()
- dia_babo_howisit_info()
- dia_babo_kap3_keepthefaith_info()
- dia_addon_lord_hagen_ornament_info()
- dia_girion_di_orcelitering_geben()
- dia_garond_janbecomesmith_yes()
- dia_oric_bruder_info()
- dia_parcival_brave_info()
- dia_gerold_food_nichts()
- dia_gorndjg_dragondead_info()
- dia_gornnw_hallo_info()
- dia_milten_di_rat_ja()
- dia_milten_di_pedrotot_info()
- dia_milten_di_dementorobsessionbook_info()
- dia_milten_di_dragonegg_info()
- dia_addon_lester_passageplantssuccess_info()
- dia_lester_di_hello_info()
- dia_lester_di_marioarsch_info()
- dia_pc_thief_di_rat_info()
- dia_addon_greg_nw_dexterfound_wo()
- dia_addon_greg_nw_caughtdexter2_info()
- dia_addon_greg_nw_waswillstdu_skip()
- dia_addon_skip_scsawgreg_info()
- dia_francis_pickpocket_doit()
- dia_addon_samuel_recipe_loushammer()
- dia_addon_samuel_recipe_lousdoublehammer()
- dia_addon_skip_adw_greggetroffen_info()
- dia_addon_roastpirate_gimmegrog_hereisgrog()
- dia_addon_brandon_schnellerhering_info()
- dia_lee_success_info()
- dia_lee_richterbeweise_info()
- dia_lee_anynews_info()
- dia_lee_drachenei_info()
- dia_lee_gotrichterspermissionforship_info()
- dia_torlof_bemycaptain2_info()
- dia_buster_bringtrophyshadowbeast_info()
- dia_cipher_darlost_info()
- dia_rod_giveitback_info()
- dia_cord_returnpatrick_info()
- dia_bullco_pepesschafe_info()
- dia_jarvis_howmanyleft_info()
- dia_bennet_di_dragonegg_info()
- dia_dar_pilztabak_info()
- dia_dar_fightagainstpalover_info()
- dia_wolf_di_hallo_info()
- dia_addon_telbor_hi_info()
- dia_addon_pardos_trank_01()
- dia_addon_pardos_trank_02()
- dia_addon_pardos_trank_03()
- dia_addon_pardos_trank_soup()
- dia_larius_richterueberfall_info()
- dia_lutero_kralle_info()
- dia_addon_fernando_bandittrader_ja()
- dia_fernando_success_info()
- dia_addon_hakon_missingpeople_info()
- dia_hakon_minenanteil_info()
- dia_zuris_minenanteil_info()
- dia_dobar_pickpocket_doit()
- dia_engor_pickpocket_doit()
- dia_addon_baltram_laresabloese_info()
- dia_addon_baltram_skipsrum_info()
- dia_gaertner_krautabak_info()
- dia_bilgot_olav_info()
- dia_talbin_foundengrom_info()
- dia_bosper_minenanteil_info()
- dia_haupttorwache_pickpocket_doit()
- dia_matteo_minenanteil_info()
- dia_addon_constantino_lesterskraeuter_info()
- dia_gritta_perm3u4u5_turnsgood()
- dia_valentino_pickpocket_doit()
- dia_salandril_pickpocket_doit()
- dia_alwin_fellansuccess_info()
- dia_jorgen_neuhier_info()
- dia_jorgen_perm5_notcaptain_info()
- dia_addon_elvrich_fernandoswaffen_info()
- dia_addon_erol_sld_info()
- dia_addon_vatras_closemeeting_info()
- dia_addon_vatras_addonsolved_info()
- dia_vatras_innoseyekaputt_info()
- dia_vatras_beginn_info()
- dia_vatras_di_pedrotot_info()
- dia_vatras_di_dementorobsessionbook_info()
- dia_garvell_returnmonty_info()
- dia_garvell_orks_info()
- dia_garvell_paladine_info()
- dia_garvell_city_info()
- dia_jack_di_greet_info()
- dia_joe_hallo_info()
- dia_addon_lares_ringback_info()
- dia_addon_lares_ringback2_info()
- dia_addon_lares_getrangerarmor_info()
- dia_addon_lares_peoplemissing_saved()
- dia_abuyin_mischung_super()
- dia_abuyin_zukunft_trance()
- dia_abuyin_zukunft2_trance()
- dia_abuyin_zukunft3_trance()
- dia_abuyin_zukunft4_trance()
- dia_abuyin_zukunft5_trance()
- dia_canthar_saraherledigt_info()
- dia_canthar_minenanteil_info()
- evt_teleportstation_func()
- b_garvellsuccess()
- b_daronsegen()

*/

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
