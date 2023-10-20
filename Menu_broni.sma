#include <amxmodx>
#include <reapi>

#define PLUGIN "Menu broni VIP"
#define VERSION "1.1"
#define AUTHOR "AMXXxD edit.PANDA"

#define FLAGA_VIP ADMIN_LEVEL_H

new g_Runda;

public plugin_init(){
	register_plugin(PLUGIN, VERSION, AUTHOR);
	
	RegisterHookChain(RG_CBasePlayer_Spawn, "RespawnGracza", 1);
	RegisterHookChain(RG_CSGameRules_RestartRound, "RestartNowaRunda", 0);
}

public RespawnGracza(id) if(is_user_alive(id) && get_user_flags(id) & FLAGA_VIP && g_Runda>2) Menu_Broni(id);

public RestartNowaRunda(){
	if(get_member_game(m_bCompleteReset)) g_Runda=1;
	else g_Runda++;
}

public Menu_Broni(id){
	new menu = menu_create("\wMenu broni\r VIP", "Handel_Menu");
		
	menu_additem(menu, "AK47 + Deagle");		
	menu_additem(menu, "M4A1 + Deagle");
	menu_additem(menu, "AWP + Deagle");
	
	menu_setprop(menu, MPROP_EXITNAME, "Wyjdz");
	menu_display(id, menu);
}

public Handel_Menu(id, menu, item){
	if(!is_user_connected(id) || item==MENU_EXIT) return;

	rg_give_item(id, "weapon_deagle", GT_REPLACE);
	rg_set_user_bpammo(id, WEAPON_DEAGLE, 35);
	rg_give_item(id, "weapon_hegrenade", GT_APPEND);
	rg_give_item(id, "weapon_flashbang", GT_APPEND);
	rg_set_user_bpammo(id, WEAPON_FLASHBANG, 2);
	rg_give_item(id, "weapon_smokegrenade", GT_APPEND);
	switch(item){
		case 0:{
			client_print_color(id, id, "^4[Menu Broni]^1 Wybrales zestaw^3 AK47 + Deagle");
			rg_give_item(id, "weapon_ak47", GT_REPLACE);
			rg_set_user_bpammo(id, WEAPON_AK47, 90);
		}
		case 1:{
			client_print_color(id, id, "^4[Menu Broni]^1 Wybrales zestaw^3 M4A1 + Deagle");
			rg_give_item(id, "weapon_m4a1", GT_REPLACE);
			rg_set_user_bpammo(id, WEAPON_M4A1, 90);
		}	
		case 2:{
			client_print_color(id, id, "^4[Menu Broni]^1 Wybrales zestaw^3 AWP + Deagle");
			rg_give_item(id, "weapon_awp", GT_REPLACE);
			rg_set_user_bpammo(id, WEAPON_AWP, 90);
		}
	}
}		
		
