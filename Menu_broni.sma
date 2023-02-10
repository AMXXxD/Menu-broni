#include <amxmodx> 
#include <fun>
#include <hamsandwich>
#include <cstrike>

#define PLUGIN "Menu broni"
#define VERSION "1.0"
#define AUTHOR "Amxxd unikalny plugin 2023"

#define FLAGA_VIP ADMIN_LEVEL_H

new g_Runda = 0;

public plugin_init() 
{
	register_plugin(PLUGIN, VERSION, AUTHOR);
	
	RegisterHam(Ham_Spawn, "player", "SpawnedEventPre", 1);
	register_event("HLTV", "event_new_round", "a", "1=0", "2=0");
	register_logevent("GameCommencing", 2, "1=Game_Commencing");
}

public SpawnedEventPre(id)
{
	if(is_user_alive(id) && get_user_flags(id) & FLAGA_VIP && g_Runda >= 2){
		Menu_Broni(id);
	}
}

public event_new_round() ++g_Runda;
public GameCommencing() g_Runda = 0;

public Menu_Broni(id)
{
	new menu = menu_create("\wMenu broni\r VIP", "Handel_Menu");
		
	menu_additem(menu, "Ak47 + Deagle");		
	menu_additem(menu, "M4a1 + Deagle");
	menu_additem(menu, "Awp + Deagle");
	
	menu_setprop(menu, MPROP_EXITNAME, "Wyjdz");
	menu_display(id, menu);
}

public Handel_Menu(id, menu, item)
{
	if(item == MENU_EXIT){
		menu_destroy(menu);
		return PLUGIN_CONTINUE;
	}	

	switch(item)
	{
		case 0: {
			client_print_color(id, id, "^4[Menu Broni]^1 Wybrales zestaw^3 Ak47 + Deagle");
			strip_user_weapons(id);
			give_item(id, "weapon_knife");			
			give_item(id, "weapon_ak47"); 
			give_item(id,"ammo_762nato"); 
			cs_set_user_bpammo(id, CSW_AK47, 90);
			give_item(id, "weapon_deagle"); 
			give_item(id,"ammo_50ae");
			cs_set_user_bpammo(id, CSW_DEAGLE, 35);
			cmd_granaty(id);
		}
		case 1: {
			client_print_color(id, id, "^4[Menu Broni]^1 Wybrales zestaw^3 M4a1 + Deagle");
			strip_user_weapons(id);
			give_item(id, "weapon_knife");				
			give_item(id, "weapon_m4a1"); 
			give_item(id,"ammo_556nato");
			cs_set_user_bpammo(id, CSW_MP5NAVY, 90);			
			give_item(id, "weapon_deagle"); 
			give_item(id,"ammo_50ae");
			cs_set_user_bpammo(id, CSW_DEAGLE, 35);
			cmd_granaty(id);
		}	
		case 2: {
			client_print_color(id, id, "^4[Menu Broni]^1 Wybrales zestaw^3 Awp + Deagle");
			strip_user_weapons(id);
			give_item(id, "weapon_knife");				
			give_item(id, "weapon_awp"); 
			give_item(id,"ammo_338magnum");
			cs_set_user_bpammo(id, CSW_AWP, 30);
			give_item(id, "weapon_deagle"); 
			give_item(id,"ammo_50ae");
			cs_set_user_bpammo(id, CSW_DEAGLE, 35);
			cmd_granaty(id);
		}			
	}
	menu_destroy(menu);
	return PLUGIN_CONTINUE;
}

public cmd_granaty(id) {
	give_item(id, "weapon_flashbang");
	cs_set_user_bpammo(id, CSW_FLASHBANG, 2);
	give_item(id, "weapon_hegrenade");
	cs_set_user_bpammo(id, CSW_HEGRENADE, 1);
	give_item(id, "weapon_smokegrenade")
	cs_set_user_bpammo(id, CSW_SMOKEGRENADE, 1);	
}		