 #include <amxmodx>
#include <fakemeta>
#include <nvault>

#define PLUGIN "KitParaMix"
#define VERSION "1.3"
#define AUTHOR "BESTIA"



new sv_talkspec, sv_alltalk;




public plugin_init()
{
	register_plugin(PLUGIN, VERSION, AUTHOR);
	register_clcmd("say !rs", "say_rs",ADMIN_MAP);
	register_clcmd("say !rjt15", "quince",ADMIN_CFG);
	register_clcmd("say !rjt25", "veinticinco", ADMIN_CFG);
	register_clcmd("say !pub", "pub", ADMIN_CFG);
	register_clcmd("say !server", "servercfg", ADMIN_CFG);
	register_forward(FM_Voice_SetClientListening, "forward_SetVoice", 0);
	sv_talkspec = register_cvar("sv_talkspec", "1");
	sv_alltalk = get_cvar_pointer("sv_alltalk");
}
public say_rs(id, level)
{	
	new Client[21] 
	get_user_name(id,Client,20)   
	if(id && get_user_flags(id) & ADMIN_MAP)
	{
		new map[33]
		client_print(id,print_chat, "Se intento cambiar el mapa por %s",Client);
		
		get_mapname(map,32)
		server_cmd("changelevel %s",map)
		return PLUGIN_HANDLED
	}else{
		client_print(id,print_chat, "No tienes permiso para cambiar el mapa!");
		return PLUGIN_HANDLED
	}
	return PLUGIN_HANDLED
}
public quince(id, level)
{
	new Client[21] 
	get_user_name(id,Client,20)   
	if(id && get_user_flags(id) & ADMIN_CFG)
	{
		server_cmd("exec rjt15.cfg");
		server_exec();
		client_print(id,print_chat, "Configuracion de RJT15 min cargada por %s",Client);
		return PLUGIN_HANDLED
	}
	return PLUGIN_CONTINUE
}
public veinticinco(id, level)
{
	new Client[21] 
	get_user_name(id,Client,20)   
	if(id && get_user_flags(id) & ADMIN_CFG)
	{
		server_cmd("exec rjt25.cfg");
		server_exec();
		client_print(id,print_chat, "Configuracion de RJT25 min cargada por %s",Client);
		return PLUGIN_HANDLED
	}
	return PLUGIN_CONTINUE
}
public pub(id, level)
{
	new Client[21] 
	get_user_name(id,Client,20)   
	if(id && get_user_flags(id) & ADMIN_CFG)
	{
		server_cmd("exec pub.cfg");
		server_exec();
		client_print(id,print_chat, "Configuracion de pub cargada por %s",Client);
		return PLUGIN_HANDLED
	}
	return PLUGIN_CONTINUE
}
public servercfg(id, level)
{
	new Client[21] 
	get_user_name(id,Client,20)   
	if(id && get_user_flags(id) & ADMIN_CFG)
	{
		server_cmd("exec server.cfg");
		server_exec();
		client_print(id,print_chat, "Configuracion del servidor cargada por %s",Client);
		return PLUGIN_HANDLED
	}
	return PLUGIN_CONTINUE
}

public plugin_cfg()
    server_cmd("amx_pausecfg add ^"%s^"", PLUGIN)

public forward_SetVoice(receiver, sender, bool:Listen)
{
    if( !get_pcvar_num(sv_talkspec) && !get_pcvar_num(sv_alltalk)
    || receiver == sender
    || !is_user_connected(receiver) || !is_user_connected(sender)
    /*|| has_muted(sender)*/ /*Native para el mute menu y otros..*/)
    {
        return FMRES_IGNORED;
    }

    if(get_user_team(receiver) != 1 && get_user_team(receiver) != 2)
    {
        engfunc(EngFunc_SetClientListening, receiver, sender, 1);
        return FMRES_SUPERCEDE;
		
    }

    return FMRES_IGNORED;
}



