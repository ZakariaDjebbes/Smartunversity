package com.smartUniversity.Api;

import com.smartUniversity.Model.User;


import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.POST;

public interface SmartUniversityAPI {
    @POST("login")
    Call<User> Login(@Body User user);
}
