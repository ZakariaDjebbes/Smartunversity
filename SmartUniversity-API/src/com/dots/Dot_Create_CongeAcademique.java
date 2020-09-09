package com.dots;

import javax.ws.rs.core.Response.Status;
import javax.xml.bind.annotation.XmlRootElement;

import com.data.DAO_CongeAcademique;
import com.data.DAO_Etudiant;
import com.jsonReaders.MessageReader;
import com.modele.Etudiant;
import com.rest.exceptions.RequestNotValidException;

@XmlRootElement
public class Dot_Create_CongeAcademique implements IDot
{
	private int id_etudiant;
	private String extension = null;

	public Dot_Create_CongeAcademique()
	{
		
	}
	
	public Dot_Create_CongeAcademique(int id_etudiant, String extension)
	{
		this.id_etudiant = id_etudiant;
		this.extension = extension;
	}

	public int getId_etudiant()
	{
		return id_etudiant;
	}

	public String getExtension()
	{
		return extension;
	}

	public void setId_etudiant(int id_etudiant)
	{
		this.id_etudiant = id_etudiant;
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
}
