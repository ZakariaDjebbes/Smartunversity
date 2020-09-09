package com.dots;

import java.util.ArrayList;
import java.util.Arrays;

import javax.ws.rs.core.Response.Status;

import com.data.DAO_Absence;
import com.data.DAO_Justification;
import com.jsonReaders.MessageReader;
import com.modele.Justification;
import com.modele.Seance.Etat_Demande;
import com.rest.exceptions.RequestNotValidException;

public class Dot_Justification_Android implements IDot
{

	private int numero_absence = 0;
	private byte[] image = null;
	private String extension = null;

	public Dot_Justification_Android()
	{

	}

	public Dot_Justification_Android(int numero_absence, byte[] image, String extension)
	{
		this.numero_absence = numero_absence;
		this.image = image;
		this.extension = extension;
	}

	public int getNumero_absence()
	{
		return numero_absence;
	}

	public void setNumero_absence(int numero_absence)
	{
		this.numero_absence = numero_absence;
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
		ArrayList<Justification> justifications = DAO_Justification.GetJustificationsByAbsence(numero_absence);
		
		for (Justification justification : justifications)
		{
			if(justification.getEtat_justification() == Etat_Demande.valide)
			{
				throw new RequestNotValidException(Status.BAD_REQUEST,
						MessageReader.GetNode("already_valid_justification"));
			}
			else if(justification.getEtat_justification() == Etat_Demande.nonTraite)
			{
				throw new RequestNotValidException(Status.BAD_REQUEST, 
						MessageReader.GetNode("already_untreated_justification"));
			}
		}
		
		if(extension == null || (!extension.equals("png") && !extension.equals("jpg") && !extension.equals("jpeg") ))
		{
			throw new RequestNotValidException(Status.BAD_REQUEST, 
					MessageReader.GetNode("only_image_files"));
		}
		
		if(DAO_Absence.GetAbsenceByNumero(numero_absence) == null)
		{
			throw new RequestNotValidException(Status.BAD_REQUEST,
					MessageReader.GetNode("absence_not_exist"));
		}		
	}
	
	@Override
	public String toString()
	{
		return "Dot_Justification_Android [numero_absence=" + numero_absence + ", image=" + Arrays.toString(image)
				+ ", extension=" + extension + "]";
	}

}
