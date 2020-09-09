package com.dots;

import java.util.Arrays;

import javax.ws.rs.core.Response.Status;

import com.data.DAO_CongeAcademique;
import com.data.DAO_Etudiant;
import com.jsonReaders.MessageReader;
import com.modele.Etudiant;
import com.rest.exceptions.RequestNotValidException;

public class Dot_CongeAcademique_Android implements IDot
{
	private int id_etudiant = 0;
	private byte[] image = null;
	private String extension = null;

	public Dot_CongeAcademique_Android()
	{

	}

	public Dot_CongeAcademique_Android(int id_etudiant, byte[] image, String extension)
	{
		this.id_etudiant = id_etudiant;
		this.image = image;
		this.extension = extension;
	}
	
	public int getId_etudiant()
	{
		return id_etudiant;
	}

	public void setId_etudiant(int id_etudiant)
	{
		this.id_etudiant = id_etudiant;
	}

	public byte[] getImage()
	{
		return image;
	}

	public void setImage(byte[] image)
	{
		this.image = image;
	}

	public String getExtension()
	{
		return extension;
	}

	public void setExtension(String extension)
	{
		this.extension = extension;
	}

	@Override
	public void Validate()
	{
		Etudiant etudiant = DAO_Etudiant.GetEtudiantById(id_etudiant);

		if(etudiant == null)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, 
					MessageReader.GetNode("student_not_exist"));
		}
		
		if(extension == null || (!extension.equals("png") && !extension.equals("jpg") && !extension.equals("jpeg") ))
		{
			throw new RequestNotValidException(Status.BAD_REQUEST,
					MessageReader.GetNode("only_image_files"));
		}
		
		if(DAO_CongeAcademique.GetCongeAcademiqueByEtudiant(id_etudiant) != null)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, 
					MessageReader.GetNode("student_have_other_request"));
		}
	}

	@Override
	public String toString()
	{
		return "Dot_CongeAcademique_Android [id_etudiant=" + id_etudiant + ", image=" + Arrays.toString(image)
				+ ", extension=" + extension + "]";
	}
}
