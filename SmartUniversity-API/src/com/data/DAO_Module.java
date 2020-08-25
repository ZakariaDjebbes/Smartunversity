package com.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;

import javax.ws.rs.core.Response.Status;

import com.modele.Module;
import com.rest.exceptions.RequestNotValidException;
import com.utility.JsonReader;

public class DAO_Module extends DAO_Initialize
{
	public static Module GetMouleByCode(String code_module)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM Module WHERE code_module = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, code_module);

				try (ResultSet resultSet = statement.executeQuery())
				{
					if (resultSet.next())
					{
						String nom = resultSet.getString(2);
						
						return new Module(code_module, nom);
					} 
					else
					{
						return null;
					}

				}
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return null;
		}
	}
	
	public static ArrayList<Module> GetAllModules()
	{
		ArrayList<Module> modules = new ArrayList<Module>();
		
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM Module;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				try (ResultSet resultSet = statement.executeQuery())
				{
					while (resultSet.next())
					{
						String code_module = resultSet.getString(1);
						String nom = resultSet.getString(2);
						
						modules.add(new Module(code_module, nom));
					} 
					
					return modules;
				}
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return null;
		}
	}
	
	public static boolean CreateMoudle(Module module)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "INSERT INTO module VALUES (?, ?);";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, module.getCode_module());
				statement.setString(2, module.getNom());
				
				return statement.executeUpdate() == 1;
			}
		} 
		catch (SQLIntegrityConstraintViolationException  e) {
			throw new RequestNotValidException(Status.BAD_REQUEST, JsonReader.GetNode("module_exist"));
		}
		catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}
	
	public static boolean UpdateModule(Module newModule, String oldCodeModule)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "UPDATE module SET code_module = ?, nom = ? WHERE code_module = ?;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, newModule.getCode_module());
				statement.setString(2, newModule.getNom());
				statement.setString(3, oldCodeModule);
				
				return statement.executeUpdate() == 1;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}
	
	public static boolean DeleteModule(String code_module)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "DELETE FROM module WHERE code_module = ? LIMIT 1;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, code_module);
				
				return statement.executeUpdate() == 1;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}
	
	public static boolean DeleteAllModule()
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "DELETE FROM module;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				return statement.executeUpdate() != 0;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}
}
