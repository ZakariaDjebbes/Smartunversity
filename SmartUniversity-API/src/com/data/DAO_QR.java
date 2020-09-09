package com.data;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.dots.Dot_Create_QR;

public class DAO_QR extends DAO_Initialize
{
	public static boolean createCodeQR(Dot_Create_QR dot_create_qr)
	{
		InputStream imageStream = new ByteArrayInputStream(dot_create_qr.getFichier());
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "INSERT INTO codeqr VALUES( ?, ?, ?, ? );";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setInt(1, dot_create_qr.getId_enseignant());
				statement.setString(2, dot_create_qr.getCode_seance());
				statement.setBlob(3,imageStream);
				statement.setString(4, dot_create_qr.getTexte_qr());
	
				return statement.executeUpdate() == 1 ? true : false;
			}
		} catch (Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		} 
	}
	
	public static Dot_Create_QR GetCodeQR(String code_seance)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "SELECT * FROM CodeQR WHERE code_seance = ?";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, code_seance);
				
				try (ResultSet resultSet = statement.executeQuery())
				{
					if(resultSet.next())
					{
						Blob blob = resultSet.getBlob(3);
						byte[] fichier =  blob.getBytes(1, (int) blob.length());
						int id_enseignant = resultSet.getInt(1);
						String texte_qr = resultSet.getString(4);
						
						Dot_Create_QR dot_create_qr = new Dot_Create_QR(id_enseignant,code_seance,fichier,texte_qr);
						return dot_create_qr;
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
	
	public static boolean DeleteCodeQR(String code_seance)
	{
		try (Connection connection = DriverManager.getConnection(dbURL, dbUser, dbPassword))
		{
			String command = "DELETE FROM codeqr WHERE code_seance = ? ;";
			try (PreparedStatement statement = connection.prepareStatement(command))
			{
				statement.setString(1, code_seance);

				return statement.executeUpdate() == 1;
			}
		}
		catch(Exception e)
		{
			System.out.println("Connection error in " + Thread.currentThread().getStackTrace()[1].getMethodName()
					+ " >>> " + e.getMessage());
			return false;
		}
	}
}
