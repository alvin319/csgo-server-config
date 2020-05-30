#include <sourcemod>

#pragma semicolon 1
#pragma newdecls required
#define CS_TEAM_T 2
#define CS_TEAM_CT 3

ConVar gCV_T_HP_Min;
ConVar gCV_T_HP_Max;
ConVar gCV_CT_HP_Min;
ConVar gCV_CT_HP_Max;
ConVar gCV_T_Armor_Min;
ConVar gCV_T_Armor_Max;
ConVar gCV_CT_Armor_Min;
ConVar gCV_CT_Armor_Max;

public void OnPluginStart()
{
    gCV_T_HP_Min = CreateConVar("sm_random_t_hp_min", "1", "Least amount of possible health for T", FCVAR_NOTIFY, true, 1.0, true, 100.0);
    gCV_T_HP_Max = CreateConVar("sm_random_t_hp_max", "99", "Maximum amount of possible health for T", FCVAR_NOTIFY, true, 1.0, true, 100.0);
    gCV_CT_HP_Min = CreateConVar("sm_random_ct_hp_min", "1", "Least amount of possible health for CT", FCVAR_NOTIFY, true, 1.0, true, 100.0);
    gCV_CT_HP_Max = CreateConVar("sm_random_ct_hp_max", "99", "Maximum amount of possible health for CT", FCVAR_NOTIFY, true, 1.0, true, 100.0);
    gCV_T_Armor_Min = CreateConVar("sm_random_t_armor_min", "1", "Least amount of possible armor for T", FCVAR_NOTIFY, true, 0.0, true, 100.0);
    gCV_T_Armor_Max = CreateConVar("sm_random_t_armor_max", "99", "Maximum amount of possible armor for T", FCVAR_NOTIFY, true, 0.0, true, 100.0);
    gCV_CT_Armor_Min = CreateConVar("sm_random_ct_armor_min", "1", "Least amount of possible armor for CT", FCVAR_NOTIFY, true, 0.0, true, 100.0);
    gCV_CT_Armor_Max = CreateConVar("sm_random_ct_armor_max", "99", "Maximum amount of possible armor for CT", FCVAR_NOTIFY, true, 0.0, true, 100.0);
    AutoExecConfig(true, "random_health", "sourcemod");
    
    HookEvent("round_start", Event_RoundStart, EventHookMode_Post);
}

public void Event_RoundStart(Event hEvent, const char[] sEventName, bool bDontBroadcast)
{
    for (int i = 1; i <= MaxClients; ++i) {
        if (IsClientInGame(i) && GetClientTeam(i) == CS_TEAM_CT) {
            SetEntityHealth(i, GetRandomInt(gCV_CT_HP_Min.IntValue, gCV_CT_HP_Max.IntValue));
            SetEntProp(i, Prop_Send, "m_ArmorValue", GetRandomInt(gCV_CT_Armor_Min.IntValue, gCV_CT_Armor_Max.IntValue));
        } else if (IsClientInGame(i) && GetClientTeam(i) == CS_TEAM_T) {
            SetEntityHealth(i, GetRandomInt(gCV_T_HP_Min.IntValue, gCV_T_HP_Max.IntValue));
            SetEntProp(i, Prop_Send, "m_ArmorValue", GetRandomInt(gCV_T_Armor_Min.IntValue, gCV_T_Armor_Max.IntValue));
        }
    }
}
