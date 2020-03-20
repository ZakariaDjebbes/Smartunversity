package com.smartUniversity.Control;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.smartUniversity.R;
import com.smartUniversity.Utility.LoginPrefConfig;

public class LoggedInEtudiantActivity extends AppCompatActivity {

    private Button logoutButton = null;
    private TextView userTextView = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.logged_in_etudiant);
        Init();
        SetupUserTextView();
        logoutButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Logout();
            }
        });
    }

    //init is called right after creteView
    private void Init()
    {
        logoutButton = findViewById(R.id.logOutButton);
        userTextView = findViewById(R.id.userNameTextView);
    }

    //Setup the usertext
    private void SetupUserTextView()
    {
        Intent intent = getIntent();
        String user = intent.getStringExtra(LoginForm.EXTRA_USER);
        userTextView.setText(user);
    }

    //Logs out the current user and removes current login prefs
    private void Logout()
    {
        LoginPrefConfig config = new LoginPrefConfig(getApplicationContext());
        config.ClearLoginPrefs();
        Intent intent = new Intent(this, LoginForm.class);
        startActivity(intent);
    }
}
