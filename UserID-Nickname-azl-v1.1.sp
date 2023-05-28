#include <sourcemod>
#include <sdktools>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = 
{
	name = "UserID in Nickname",
	author = "AZzeL",
	description = "Adauga UserID in Nickname",
	version = "1.0",
    	url = "https://steamcommunity.com/id/azzel"
};

public void OnPluginStart()
{
	HookUserMessage(GetUserMessageId("SayText2"), Hook_SayText2, true);
}

public void OnClientPostAdminCheck(int client)
{
      char oldname[64], newname[64];
        
      GetClientName(client, oldname, sizeof(oldname));
      Format(newname, sizeof(newname), "%s [#%d]", oldname, GetClientUserId(client));
      SetClientName(client, newname);
}

public Action Hook_SayText2(UserMsg msg_id, any msg, const int[] players, int playersNum, bool reliable, bool init)
{
	char[] sMessage = new char[24];

	if(GetUserMessageType() == UM_Protobuf)
	{
		Protobuf pbmsg = msg;
		pbmsg.ReadString("msg_name", sMessage, 24);
	}

	else
	{
		BfRead bfmsg = msg;
		bfmsg.ReadByte();
		bfmsg.ReadByte();
		bfmsg.ReadString(sMessage, 24, false);
	}

	if(StrEqual(sMessage, "#Cstrike_Name_Change"))
	{
		return Plugin_Handled;
	}

	return Plugin_Continue;
}
