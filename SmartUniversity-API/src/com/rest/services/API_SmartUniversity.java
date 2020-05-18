package com.rest.services;

import java.util.TimeZone;

import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;

import com.data.DAO_Initialize;

@ApplicationPath("/api")
public class API_SmartUniversity extends Application
{
	public API_SmartUniversity()
	{
		TimeZone timeZone;
		timeZone = TimeZone.getTimeZone("GMT+0:00");
		TimeZone.setDefault(timeZone);
		System.out.println("Smart University API is Running... Server Up");
		DAO_Initialize.Start();
		System.out.println("JDBC Driver Initialized...");
	}
}
