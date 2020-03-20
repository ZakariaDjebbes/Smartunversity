package com.smartUniversity.Utility;

import android.content.Context;
import android.content.SharedPreferences;

public class LoginPrefConfig {
    private SharedPreferences prefs = null;
    private SharedPreferences.Editor editor = null;
    private Context context = null;

    private static final String LOGIN_PREFRS = "login_prefs";
    private static final String LOGIN_STAY_LOGGED = "login_status";
    private static final String LOGIN_USERNAME = "login_username";
    private static final String LOGIN_PASSWORD = "login_password";

    public LoginPrefConfig(Context config)
    {
        context = config;
        prefs = context.getSharedPreferences(LOGIN_PREFRS, context.MODE_PRIVATE);
    }

    public void SerializeLoginPrefs(boolean stayLogged, String username, String password)
    {
        editor = prefs.edit();
        editor.putBoolean(LOGIN_STAY_LOGGED, stayLogged);
        editor.putString(LOGIN_USERNAME, username);
        editor.putString(LOGIN_PASSWORD, password);
        editor.commit();
    }

    public void ClearLoginPrefs()
    {
        prefs.edit().clear().commit();
    }

    public boolean GetStayLogged()
    {
        return prefs.getBoolean(LOGIN_STAY_LOGGED, false);
    }

    public String GetUsername()
    {
        return prefs.getString(LOGIN_USERNAME, "");
    }

    public String GetPassword() { return  prefs.getString(LOGIN_PASSWORD, "");}
}
