package com.smartUniversity.Control;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.smartUniversity.Api.SmartUniversityAPI;
import com.smartUniversity.Model.User;
import com.smartUniversity.R;
import com.smartUniversity.Utility.LoginPrefConfig;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class LoginForm extends AppCompatActivity {
    //Extra data sent to the LoggedInEtudiantAcitivy...
    public static final String EXTRA_USER = "com.smartUniversity.USER";
    public static final String EXTRA_PASSWORD = "com.smartUniversity.PASSWORD";
    public static final String EXTRA_STAY_LOGGED_IN = "com.smartUniversity.STAY_LOGGED_IN";
    //actual elements on the activity
    private EditText userText = null;
    private EditText passwordText = null;
    private CheckBox stayLoggedInCheckBox = null;
    private Button connectButton = null;
    private TextView loginResultTextView = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.login_form);
        CheckLoginPrefs();
        Init();
        //Connect button click event...
        connectButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                //ShowToastMessage();
                CheckUser();
            }
        });
    }

    //login prefs...
    private void CheckLoginPrefs() {
        LoginPrefConfig config = new LoginPrefConfig(getApplicationContext());
        if(config.GetStayLogged() == true)
        {
            Login(config.GetUsername(), config.GetPassword());
        }
    }

    //Called right after the creating of the activity, used to initialize values / behaviours.
    private void Init() {
        userText = findViewById(R.id.userText);
        passwordText = findViewById(R.id.passwordText);
        stayLoggedInCheckBox = findViewById(R.id.stayLoggedInCheckbox);
        connectButton = findViewById(R.id.connectButton);
        loginResultTextView = findViewById(R.id.login_result_textView);
    }

    //show a toast message for debugging
    private void ShowToastMessage() {
        String user = userText.getText().toString();
        String password = passwordText.getText().toString();
        boolean stayLoggedIn = stayLoggedInCheckBox.isChecked();

        String res = String.format("Name = %s \nPassword = %s \nKeep logged = %s", user, password, stayLoggedIn);

        Toast.makeText(LoginForm.this, res, Toast.LENGTH_SHORT).show();
    }

    //Checks the user from the API...
    private void CheckUser()
    {
        String baseUrl = getResources().getString(R.string.auth_service_url);

        String user = userText.getText().toString();
        String password = passwordText.getText().toString();
        boolean stayLoggedIn = stayLoggedInCheckBox.isChecked();

        if(user.matches("") || password.matches(""))
        {
            String resultText = getResources().getString(R.string.login_form_fill_all_fields);
            loginResultTextView.setText(resultText);
            System.out.println("We in cond");
            return;
        }

        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl(baseUrl)
                .addConverterFactory(GsonConverterFactory.create())
                .build();
        SmartUniversityAPI smartUniversityAPI = retrofit.create(SmartUniversityAPI.class);
        Call<User> call = smartUniversityAPI.Login(new User(user, password));
        call.enqueue(new Callback<User>() {
            @Override
            public void onResponse(Call<User> call, Response<User> response) {
                if(!response.isSuccessful())
                {
                    String resultText = getResources().getString(R.string.login_form_login_result_on_response);
                    resultText += response.code();
                    try {
                        System.out.println("Erreur... onResponse >>> Code: " + response.code() + " " + response.errorBody().string());
                    }catch (Exception e)
                    {
                        e.printStackTrace();
                    }
                    loginResultTextView.setText(resultText);
                    return;
                }
                LoginPrefConfig loginConfig = new LoginPrefConfig(getApplicationContext());
                loginConfig.SerializeLoginPrefs(stayLoggedIn, user, password);
                Login(user, password);
            }

            @Override
            public void onFailure(Call<User> call, Throwable t) {
                String resultText = getResources().getString(R.string.login_form_login_result_on_failure);
                System.out.println("Erreur... OnFailure >>> Erreur: " + t.getMessage() + " Call: " + call.request().body());
                loginResultTextView.setText(resultText);
            }
        });

    }

    //changes current activity...
    private void Login(String user, String password) {
        Intent intent = new Intent(this, LoggedInEtudiantActivity.class);
        intent.putExtra(EXTRA_USER, user);
        intent.putExtra(EXTRA_PASSWORD, password);
        startActivity(intent);
    }

}
